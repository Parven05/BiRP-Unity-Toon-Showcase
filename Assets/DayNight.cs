using UnityEngine;

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

    [Header("Mode Control")]
    [SerializeField] private bool isNight = false;
    [SerializeField] private bool isEvening = false;

    void Start()
    {
        dayCameraColor = Camera.main.backgroundColor;
        dayAmbientLight = RenderSettings.ambientLight;
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha3)) // Number 3 key for night
        {
            isNight = !isNight;
            isEvening = false;

            if (isNight) SetNightMode();
            else SetDayMode();
        }

        if (Input.GetKeyDown(KeyCode.Alpha2)) // Number 2 key for evening
        {
            isEvening = !isEvening;
            isNight = false;

            if (isEvening) SetEveningMode();
            else SetDayMode();
        }

        if (Input.GetKeyDown(KeyCode.Alpha1)) // Number 1 key for day
        {
            isNight = false;
            isEvening = false;
            SetDayMode();
        }
    }

    void SetNightMode()
    {
        Camera.main.backgroundColor = nightColor;
        RenderSettings.ambientLight = nightAmbientLight;
        RenderSettings.fogColor = nightColor;
        RenderSettings.fogDensity = nightFogDensity;
        directionalLight.enabled = false;
        spotLight.SetActive(true);
    }

    void SetDayMode()
    {
        Camera.main.backgroundColor = dayCameraColor;
        RenderSettings.ambientLight = dayAmbientLight;
        RenderSettings.fogColor = dayFogColor;
        RenderSettings.fogDensity = dayFogDensity;
        directionalLight.enabled = true;
        spotLight.SetActive(false);
    }

    void SetEveningMode()
    {
        Camera.main.backgroundColor = eveningCameraColor;
        RenderSettings.ambientLight = eveningAmbientLight;
        RenderSettings.fogColor = eveningFogColor;
        RenderSettings.fogDensity = eveningFogDensity;
        directionalLight.enabled = true;
        directionalLight.intensity = 0.5f;
        spotLight.SetActive(false);
    }
}
