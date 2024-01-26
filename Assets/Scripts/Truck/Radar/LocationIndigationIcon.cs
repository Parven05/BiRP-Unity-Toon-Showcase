using System;
using UnityEngine;
using UnityEngine.UI;

public class LocationIndigationIcon : MonoBehaviour
{
    public static event Action<BaseEntity> OnLocationIndigationIconDestroyed;
    [SerializeField] private float destroyTimerMax = 5f;
    [SerializeField] private float destroyTimerSpeed = 0.5f;
    private float destroyTimer;

    private BaseEntity baseEntity;
    private Image indigatorImage;
    void Start()
    {
        indigatorImage = GetComponent<Image>();
        destroyTimer = destroyTimerMax;
    }

    void Update()
    {
        destroyTimer -= Time.deltaTime * destroyTimerSpeed;

        // Calculate the new alpha value using Color.Lerp
        Color currentColor = indigatorImage.color;
        currentColor.a = Mathf.Lerp(0.0f, 1.0f, destroyTimer / destroyTimerMax);  // Swap the arguments
        indigatorImage.color = currentColor;

        if (destroyTimer < 0)
        {
            Destroy(gameObject);
        }
    }

    public void SetBaseEntity(BaseEntity entity)
    {
        this.baseEntity = entity;
    }
    private void OnDestroy()
    {
        OnLocationIndigationIconDestroyed?.Invoke(baseEntity);
    }
}
