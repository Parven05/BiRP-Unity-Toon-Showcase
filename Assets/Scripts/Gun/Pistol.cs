using TMPro;
using UnityEngine;

public class Pistol : MonoBehaviour
{
   
    //Gun stats
    public int damage;
    public float timeBetweenShooting, spread, range, reloadTime, timeBetweenShots;
    public int magazineSize, bulletsPerTap;
    public bool allowButtonHold;
    int bulletsLeft, bulletsShot;

    //bools 
    bool shooting, readyToShoot, reloading;

    //Reference
    public Camera fpsCam;
    public Transform attackPoint;
    public RaycastHit rayHit;
    public LayerMask whatIsEnemy;

    //Graphics
    public GameObject bulletHoleGraphic;
    public ParticleSystem shootParticle;
    public ParticleSystem shootParticleVfx;
    //public CamShake camShake;
    public float camShakeMagnitude, camShakeDuration;
    public TextMeshProUGUI text;
    public AudioClip shootAudioClip;
    public AudioClip impactAudioClip;
    public AudioClip ammoEmpty;
    public AudioClip reloadPistol;
    private Animator animator;

    private Mag mag;
    private void Awake()
    {
        bulletsLeft = magazineSize;
        readyToShoot = true;
        animator = GetComponent<Animator>();
        mag = GetComponentInChildren<Mag>();
    }
    private void Update()
    {
        MyInput();

        //SetText
        text.SetText(bulletsLeft + " / " + magazineSize);
    }
    private void MyInput()
    {
        if (allowButtonHold) shooting = Input.GetKey(KeyCode.Mouse0);
        else shooting = Input.GetKeyDown(KeyCode.Mouse0);

        if (Input.GetKeyDown(KeyCode.R) && bulletsLeft < magazineSize && !reloading)
        {
            /*Reload()*/
            AudioSource.PlayClipAtPoint(reloadPistol, transform.position, 1f);
            animator.SetTrigger("Reload");
        }

        //Shoot
        if (readyToShoot && shooting && !reloading && bulletsLeft > 0)
        {
            bulletsShot = bulletsPerTap;
            Shoot();
        }

        if(bulletsLeft <= 0 && shooting)
        {
            AudioSource.PlayClipAtPoint(ammoEmpty, transform.position, 1f);
        }
    }
    private void Shoot()
    {
        readyToShoot = false;

        //Spread
        float x = Random.Range(-spread, spread);
        float y = Random.Range(-spread, spread);

        //Calculate Direction with Spread
        Vector3 direction = fpsCam.transform.forward + new Vector3(x, y, 0);

        //RayCast
        if (Physics.Raycast(fpsCam.transform.position, direction, out rayHit, range, whatIsEnemy))
        {
            Debug.Log(rayHit.collider.name);
            Rigidbody hitRb = null;
            if (rayHit.collider.TryGetComponent(out IDamagable damagable) ||
                rayHit.collider.TryGetComponent(out hitRb))
            {
                damagable?.TakeDamage(damage);
                
                if(hitRb != null)
                {
                    Vector3 dir = (rayHit.point - hitRb.position).normalized;
                    hitRb.AddForce(-dir * 3, ForceMode.Impulse);
                }
            }
        }

        //ShakeCamera
        //camShake.Shake(camShakeDuration, camShakeMagnitude);

        //Graphics
        animator.SetTrigger("IsShoot");
        AudioSource.PlayClipAtPoint(shootAudioClip, transform.position, 1f);
        Instantiate(bulletHoleGraphic, rayHit.point, Quaternion.Euler(0, 180, 0));
        AudioSource.PlayClipAtPoint(impactAudioClip, transform.position, 1f);
        //Instantiate(muzzleFlash, attackPoint.position, Quaternion.identity);
        shootParticle.Emit(1);
        shootParticleVfx.Play();
        
        bulletsLeft--;
        bulletsShot--;

        Invoke("ResetShot", timeBetweenShooting);

        if (bulletsShot > 0 && bulletsLeft > 0)
            Invoke("Shoot", timeBetweenShots);
    }
    private void ResetShot()
    {
        readyToShoot = true;
    }
    public void Reload()
    {
        mag.Eject();
        reloading = true;
        Invoke("ReloadFinished", reloadTime);
    }
    private void ReloadFinished()
    {
        bulletsLeft = magazineSize;
        reloading = false;
    }
}
