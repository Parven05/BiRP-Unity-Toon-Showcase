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
    [Header("Radar Variables")]
    [SerializeField] private float radarSpeed = 5f;
    [SerializeField] private float detectionThresholdAngle = 30f;
    [SerializeField] private float detectionRadius = 20f;
    private Collider[] colliderArray = new Collider[20];
    private List<BaseEntity> enemiesList = new List<BaseEntity>(20);
    [Header("Radar Debug Variables")]
    [SerializeField] private bool canRotateRadar = true;

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

        int colliderCount = Physics.OverlapSphereNonAlloc(transform.position, detectionRadius, colliderArray, detectableLayerMask);

        if (colliderCount > 0)
        {
            foreach (Collider collider in colliderArray)
            {
                if (collider != null)
                {
                    Vector3 direction = collider.gameObject.transform.position - transform.position;
                    direction.Normalize();
                    float dotProduct = Vector3.Dot(transform.forward, direction);

                    if (dotProduct > Mathf.Cos(Mathf.Deg2Rad * detectionThresholdAngle))
                    {
                        Debug.DrawLine(collider.gameObject.transform.position, transform.position, Color.red);
                        Debug.Log("Detcted Entity At : " + collider.gameObject.transform.position);

                        if (collider.gameObject.TryGetComponent(out BaseEntity baseEntity))
                        {
                            if (!enemiesList.Contains(baseEntity))
                            {
                                enemiesList.Add(baseEntity);
                                CreateIconOnUiContainer(baseEntity);
                            }
                        }
                    }
                }
            }
        }
    }

    private void CreateIconOnUiContainer(BaseEntity baseEntity)
    {
        // Calculate the position of the icon on the radar UI based on radar-to-enemy radius
        Vector3 directionToEnemy = baseEntity.transform.position - transform.position;
        float distanceToEnemy = directionToEnemy.magnitude;
        float normalizedDistance = Mathf.Clamp01(distanceToEnemy / detectionRadius);

        // Calculate the angle of the enemy relative to the radar's forward direction
        float angle = Vector3.Angle(transform.forward, directionToEnemy);

        // Create an instance of the pingPrefab on radarUIContainer
        GameObject iconInstance = Instantiate(pingPrefab, radarUIContainer);
        RectTransform iconRectTransform = iconInstance.GetComponent<RectTransform>();
        LocationIndigationIcon locationIndigationIcon = iconInstance.GetComponent<LocationIndigationIcon>();

        // Set the position of the icon based on the normalized distance and angle
        float radius = radarUIContainer.rect.width / 2f;
        float xPosition = normalizedDistance * radius * Mathf.Cos(Mathf.Deg2Rad * angle);
        float yPosition = normalizedDistance * radius * Mathf.Sin(Mathf.Deg2Rad * angle);

        iconRectTransform.anchoredPosition = new Vector2(xPosition, yPosition);

        locationIndigationIcon.SetBaseEntity(baseEntity);
    }




}
