using UnityEngine;

public class DayNight : MonoBehaviour
{ 
  [SerializeField] private Color nightColor = Color.black;
  [SerializeField] private Color dayFogColor;
  [SerializeField] private float dayFogDensity;
  [SerializeField] private float nightFogDensity;
  [SerializeField] private Color dayCameraColor;
  [ColorUsage(true, true)]
  [SerializeField] private Color dayAmbientLight;
  [ColorUsage(true, true)]
  [SerializeField] private Color nightAmbientLight;
  [SerializeField] private GameObject directionalLight;
  [SerializeField] private GameObject spotLight;
  [SerializeField] private bool isNight = false;

    void Start()
    {
        // Save the original camera color and ambient light
        dayCameraColor = Camera.main.backgroundColor;
        dayAmbientLight = RenderSettings.ambientLight;
    }

    void Update()
    {
        // Toggle night mode on 'N' key press
        if (Input.GetKeyDown(KeyCode.N))
        {
            isNight = !isNight;

            if (isNight)
            {
                SetNightMode();
            }
            else
            {
                SetDayMode();
            }
        }
    }

    void SetNightMode()
    {
        // Set camera background color to night color
        Camera.main.backgroundColor = nightColor;

        // Set ambient light to night color
        RenderSettings.ambientLight = nightAmbientLight;
        
        //Set fog to black
        RenderSettings.fogColor = nightColor;
        
        //Set fog density
        RenderSettings.fogDensity = nightFogDensity;

        // Turn off directional light if exists
        directionalLight.SetActive(false);
        
        //Turn on flashlight
        spotLight.SetActive(true);
    }

    void SetDayMode()
    {
        // Restore original camera color
        Camera.main.backgroundColor = dayCameraColor;

        // Restore original ambient light
        RenderSettings.ambientLight = dayAmbientLight;
        
        //Set fog to Orange
        RenderSettings.fogColor = dayFogColor;
        
        //Set fog density
        RenderSettings.fogDensity = dayFogDensity;

        // Turn on directional light if exists
        directionalLight.SetActive(true);
        
        //Turn off flashlight
        spotLight.SetActive(false);
    }
}
