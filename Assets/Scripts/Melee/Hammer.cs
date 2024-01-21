using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Hammer : MonoBehaviour
{
    [SerializeField] Vector3 endTargetRotation;
    [SerializeField] float hammerAttackDelay;
    [SerializeField] Ease hammerEase;

    private Vector3 oldRotation;
    private bool isAttackPlaying;

    private void Awake()
    {
        oldRotation = transform.eulerAngles;
    }
    private void DoAttack()
    {
        //Quaternion targeRot = Quaternion.LookRotation(endTargetRotation, transform.forward);
        //transform.DORotateQuaternion(targeRot,hammerAttackDelay).SetEase(hammerEase);
        if (isAttackPlaying) return;

        isAttackPlaying = true;
        transform.DORotate(endTargetRotation, hammerAttackDelay, RotateMode.Fast).SetEase(hammerEase).OnComplete(() =>
        {
            transform.DORotate(oldRotation, 0.1f, RotateMode.Fast).SetEase(hammerEase).OnComplete(() =>
            {
                isAttackPlaying = false;
            });
        });
    }

    private void Update()
    {
        if(Input.GetMouseButtonDown(0))
        {
            DoAttack();
        }
    }
}
