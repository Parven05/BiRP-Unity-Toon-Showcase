using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Projectile : MonoBehaviour
{
    private void OnTriggerEnter(Collider other)
    {
        if(other != null && other.gameObject.layer != gameObject.layer)
        {
            if(other.gameObject.TryGetComponent(out IDamagable damagable))
            {
                damagable.TakeDamage(10f);
            }
            Destroy(gameObject);
            Debug.Log("Dummy Damage Performed");
        }
    }
}
