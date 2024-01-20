using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Mag : MonoBehaviour
{
    [SerializeField] private GameObject dummyMag;

    [ContextMenu("Test Eject")]
    public void Eject()
    {
        //transform.SetParent(null);
        //rb.isKinematic = false;
        //rb.AddForce(-transform.up * 0.5f,ForceMode.Impulse);
        //Destroy(rb.gameObject,10f);

        var magSpawned = Instantiate(dummyMag, transform);
        magSpawned.transform.localPosition = Vector3.zero;
        magSpawned.transform.localRotation = transform.rotation;

        magSpawned.transform.SetParent(null);

        magSpawned.GetComponent<Rigidbody>().AddForce(-transform.up * 0.5f, ForceMode.Impulse);
        Destroy(magSpawned, 10f);
    }
}
