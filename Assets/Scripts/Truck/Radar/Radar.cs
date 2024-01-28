using Ilumisoft.RadarSystem;
using Ilumisoft.RadarSystem.UI;
using System;
using System.Collections.Generic;
using UnityEngine;

public class Radar : MonoBehaviour
{
    [Header("Radar References")]
    [SerializeField] private RectTransform radarUIContainer;
    [SerializeField] private GameObject pingPrefab;
    [SerializeField] private Transform radarAnalogeTransform;
    [SerializeField] private LayerMask detectableLayerMask;
    private Vector3 radarOrginPosition;
    [Header("Radar Variables")]
    [SerializeField] private float radarSpeed = 5f;
    [SerializeField] private float detectionThresholdAngleCos = 30f;
    [SerializeField] private float detectionThresholdAngleSin = 30f;
    [SerializeField] private float detectionRadius = 20f;
    private Collider[] colliderArray = new Collider[20];
    private List<BaseEntity> enemiesList = new List<BaseEntity>(20);
    [Header("Radar Debug Variables")]
    [SerializeField] private bool canRotateRadar = true;

    private void Awake()
    {
        radarOrginPosition = transform.position + -transform.up * 3f;
    }
    private void Start()
    {
        LocationIndigationIcon.OnLocationIndigationIconDestroyed += LocationIndigationIcon_OnLocationIndigationIconDestroyed;
    }
    private void OnDisable()
    {
        LocationIndigationIcon.OnLocationIndigationIconDestroyed -= LocationIndigationIcon_OnLocationIndigationIconDestroyed;
    }

    private void LocationIndigationIcon_OnLocationIndigationIconDestroyed(BaseEntity DesroyedEntity)
    {
        enemiesList.Remove(DesroyedEntity);
    }

    private void Update()
    {
        if (canRotateRadar)
        {
            transform.eulerAngles -= new Vector3(0, Time.deltaTime * radarSpeed * 5, 0);
            radarAnalogeTransform.eulerAngles -= new Vector3(0, 0, Time.deltaTime * radarSpeed * 5);
        }

        // Clear the colliderArray at the beginning of each frame
        Array.Clear(colliderArray, 0, colliderArray.Length);

        int colliderCount = Physics.OverlapSphereNonAlloc(radarOrginPosition, detectionRadius, colliderArray, detectableLayerMask);

        if (colliderCount > 0)
        {
            foreach (Collider collider in colliderArray)
            {
                if (collider != null)
                {
                    Vector3 direction = collider.gameObject.transform.position - radarOrginPosition;
                    direction.Normalize();
                    float dotProduct = Vector3.Dot(transform.forward, direction);

                    if (dotProduct > Mathf.Cos(Mathf.Deg2Rad * detectionThresholdAngleCos))
                    {
                        Debug.DrawLine(collider.gameObject.transform.position, radarOrginPosition, Color.red);

                        if (collider.gameObject.TryGetComponent(out BaseEntity baseEntity))
                        {
                            if (!enemiesList.Contains(baseEntity))
                            {
                                Debug.Log("Detected Entity At : " + collider.gameObject.transform.position);
                                enemiesList.Add(baseEntity);
                                CreateIconOnUiContainer(baseEntity);
                            }
                        }
                    }
                    else
                    {
                        Debug.DrawLine(collider.gameObject.transform.position, radarOrginPosition, Color.green);
                    }

                }
            }
        }
    }

    private void CreateIconOnUiContainer(BaseEntity baseEntity)
    {
        //// Calculate the position of the icon on the radar UI based on radar-to-enemy radius
        //Vector3 directionToEnemy = baseEntity.transform.position - radarOrginPosition;
        //float distanceToEnemy = directionToEnemy.magnitude;
        //float normalizedDistance = Mathf.Clamp01(distanceToEnemy / detectionRadius);

        //// Calculate the angle of the enemy relative to the radar's forward direction
        //float angle = Vector3.Angle(transform.forward, directionToEnemy);

        //// Create an instance of the pingPrefab on radarUIContainer
        //GameObject iconInstance = Instantiate(pingPrefab, radarUIContainer);
        //RectTransform iconRectTransform = iconInstance.GetComponent<RectTransform>();
        //LocationIndigationIcon locationIndigationIcon = iconInstance.GetComponent<LocationIndigationIcon>();

        //locationIndigationIcon.SetBaseEntity(baseEntity);

        //// Set the position of the icon based on the normalized distance and angle
        //float radius = radarUIContainer.rect.width / 2f;
        //float xPosition = normalizedDistance * radius * Mathf.Cos(Mathf.Deg2Rad * angle);
        //float yPosition = normalizedDistance * radius * Mathf.Sin(Mathf.Deg2Rad * angle);

        //iconRectTransform.anchoredPosition = new Vector2(xPosition, yPosition);

        if (TryGetIconLocation(baseEntity, out var iconLocation))
        {
            //icon.SetVisible(true);

            //var rectTransform = icon.GetComponent<RectTransform>();

            //rectTransform.anchoredPosition = iconLocation;

            //// Create an instance of the pingPrefab on radarUIContainer
            GameObject iconInstance = Instantiate(pingPrefab, radarUIContainer);
            RectTransform iconRectTransform = iconInstance.GetComponent<RectTransform>();
            iconRectTransform.anchoredPosition = iconLocation;
            LocationIndigationIcon locationIndigationIcon = iconInstance.GetComponent<LocationIndigationIcon>();
            locationIndigationIcon.SetBaseEntity(baseEntity);
        }
        else
        {
            Debug.LogWarning("No Icon Found");
        }
    }

    private bool TryGetIconLocation(BaseEntity baseEntity, out Vector2 iconLocation)
    {
        iconLocation = GetDistanceToRadar(baseEntity);

        float radarSize = GetRadarUISize();

        var scale = radarSize / detectionRadius;

        iconLocation *= scale;

        // Rotate the icon by the players y rotation if enabled
        //if (ApplyRotation)
        //{
            // Get the forward vector of the player projected on the xz plane
            var playerForwardDirectionXZ = Vector3.ProjectOnPlane(radarOrginPosition + Vector3.forward, Vector3.up);

            // Create a roation from the direction
            var rotation = Quaternion.LookRotation(playerForwardDirectionXZ);

            // Mirror y rotation
            var euler = rotation.eulerAngles;
            euler.y = -euler.y;
            rotation.eulerAngles = euler;

            // Rotate the icon location in 3D space
            var rotatedIconLocation = rotation * new Vector3(iconLocation.x, 0.0f, iconLocation.y);

            // Convert from 3D to 2D
            iconLocation = new Vector2(rotatedIconLocation.x, rotatedIconLocation.z);
        //}

        if (iconLocation.sqrMagnitude < radarSize * radarSize)
        {
            // Make sure it is not shown outside the radar
            iconLocation = Vector2.ClampMagnitude(iconLocation, radarSize);

            return true;
        }

        return false;
    }

    private float GetRadarUISize()
    {
        return radarUIContainer.rect.width / 2;
    }

    private Vector2 GetDistanceToRadar(BaseEntity baseEntity)
    {
        Vector3 distanceToPlayer = baseEntity.transform.position - radarOrginPosition;

        return new Vector2(distanceToPlayer.x, distanceToPlayer.z);
    }

}
