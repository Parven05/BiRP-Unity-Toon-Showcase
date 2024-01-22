using DG.Tweening;
using System.Collections;
using UnityEngine;

public class Hammer : MonoBehaviour
{
    [SerializeField] private Animator animator;
    private bool canAttack = true;
    [SerializeField] private float timeBetweenAttack = 1f;

    private void DoAttack()
    {
        if (canAttack)
        {
            animator.SetTrigger("HammerStrike_1");
            canAttack = false;
            StartCoroutine(ResetAttack());
        }
    }

    private IEnumerator ResetAttack()
    {
        yield return new WaitForSeconds(timeBetweenAttack);
        canAttack = true;
    }

    private void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            DoAttack();
        }
    }
}
