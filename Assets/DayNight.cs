using UnityEngine;
using TMPro;

public class DayNight : MonoBehaviour
{
    [Header("Colors")]
    [SerializeField] private Color dayCameraColor;
    [SerializeField] private Color eveningCameraColor;
    [SerializeField] private Color nightColor;

    [Header("Fog")]
    [SerializeField] private Color dayFogColor;
    [SerializeField] private Color eveningFogColor;
    [SerializeField] private float dayFogDensity;
    [SerializeField] private float eveningFogDensity;
    [SerializeField] private float nightFogDensity;

    [Header("Ambient Light")]
    [ColorUsage(true, true)]
    [SerializeField] private Color dayAmbientLight;
    [ColorUsage(true, true)]
    [SerializeField] private Color eveningAmbientLight;
    [ColorUsage(true, true)]
    [SerializeField] private Color nightAmbientLight;

    [Header("Lights")]
    [SerializeField] private Light directionalLight;
    [SerializeField] private GameObject spotLight;

    [Header("Timer")]
    [SerializeField] private float totalTransitionTimeInMinutes = 1f; // Total time for one complete day-night cycle in minutes
    [SerializeField] private TextMeshProUGUI timerText;

    private float timer = 0f;

    void Start()
    {
        dayCameraColor = Camera.main.backgroundColor;
        dayAmbientLight = RenderSettings.ambientLight;

        // Start the timer
        timer = 0f;
        UpdateTimerText();
    }

    void Update()
    {
        // Update the timer
        timer += Time.deltaTime;
        UpdateTimerText();

        // Calculate the lerp value based on the timer
        float lerpValue = Mathf.Clamp01(timer / (totalTransitionTimeInMinutes * 60f));

        // Smoothly transition between modes
        if (lerpValue < 0.5f) // Transition from day to evening
        {
            SetDayToEveningMode(lerpValue * 2f);
        }
        else // Transition from evening to night
        {
            SetEveningToNightMode((lerpValue - 0.5f) * 2f);
        }

        // Check if one complete day-night cycle is done
        if (timer >= totalTransitionTimeInMinutes * 60f)
        {
            timer = 0f;
        }
    }

    void SetDayToEveningMode(float lerpValue)
    {
        Camera.main.backgroundColor = Color.Lerp(dayCameraColor, eveningCameraColor, lerpValue);
        RenderSettings.ambientLight = Color.Lerp(dayAmbientLight, eveningAmbientLight, lerpValue);
        RenderSettings.fogColor = Color.Lerp(dayFogColor, eveningFogColor, lerpValue);
        RenderSettings.fogDensity = Mathf.Lerp(dayFogDensity, eveningFogDensity, lerpValue);
        directionalLight.enabled = true;
        directionalLight.intensity = Mathf.Lerp(1.0f, 0.5f, lerpValue);
        spotLight.SetActive(false);
    }

    void SetEveningToNightMode(float lerpValue)
    {
        Camera.main.backgroundColor = Color.Lerp(eveningCameraColor, nightColor, lerpValue);
        RenderSettings.ambientLight = Color.Lerp(eveningAmbientLight, nightAmbientLight, lerpValue);
        RenderSettings.fogColor = Color.Lerp(eveningFogColor, nightColor, lerpValue);
        RenderSettings.fogDensity = Mathf.Lerp(eveningFogDensity, nightFogDensity, lerpValue);
        directionalLight.intensity = Mathf.Lerp(0.5f, 0.0f, lerpValue);
        directionalLight.enabled = false;
        spotLight.SetActive(true);
    }

    void UpdateTimerText()
    {
        // Display the timer in the TextMeshPro text component in minutes
        if (timerText != null)
        {
            float remainingTimeInMinutes = (totalTransitionTimeInMinutes * 60f) - timer;
            timerText.text = string.Format("{0:00}:{1:00}", Mathf.Floor(remainingTimeInMinutes / 60), Mathf.Floor(remainingTimeInMinutes % 60));
        }
    }
}
