using UnityEngine;

public class RobotHealth : MonoBehaviour
{
    private float currentHealth;
    private float healthMax = 100f;
    private float healthMin = 0f;

    private void Awake()
    {
        currentHealth = healthMax;
    }

    public void AddHealth(float health)
    {
        this.currentHealth += Mathf.Clamp(health, healthMin, healthMax);
    }
    public void DecreaseHealth(float health)
    {
        this.currentHealth -= Mathf.Clamp(health, healthMin, healthMax); ;
    }

    public float GetHealth()
    {
        return currentHealth;
    }

    [ContextMenu("Test Decrease Health")]
    public void TestDecreaseHealth()
    {
        float toDecreaseHealth = 50;
        this.currentHealth -= Mathf.Clamp(toDecreaseHealth, healthMin, healthMax);
    }
}
