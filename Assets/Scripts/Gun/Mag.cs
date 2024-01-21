using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Mag : MonoBehaviour
{
    [SerializeField] private GameObject dummyMag;

    [ContextMenu("Test Eject")]
    public void Eject()
    {

        var magSpawned = Instantiate(dummyMag, transform);
        magSpawned.transform.localPosition = Vector3.zero;
        magSpawned.transform.localRotation = transform.rotation;

        magSpawned.transform.SetParent(null);

        magSpawned.GetComponent<Rigidbody>().AddForce(Vector3.down * 0.5f, ForceMode.Impulse);
        Destroy(magSpawned, 10f);
    }
}
