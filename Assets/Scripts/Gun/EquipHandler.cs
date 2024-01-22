using DG.Tweening;
using UnityEngine;

public class EquipHandler : MonoBehaviour
{
    [SerializeField] private Transform pistolTransform;
    [SerializeField] private Transform remoteTransform;
    [SerializeField] private Transform hammerTransform;

    [SerializeField] private bool isActivePistol = false;
    [SerializeField] private bool isActiveRemote = false;
    [SerializeField] private bool isActiveHammer = false;

    [SerializeField] private Ease pistolEaseMode = Ease.InBack;
    [SerializeField] private Ease remoteEaseMode = Ease.InBack;
    [SerializeField] private Ease hammerEaseMode = Ease.InBack;

    private void Awake()
    {
        SetActivePistol(isActivePistol);
        SetActiveRemote(isActiveRemote);
        SetActiveHammer(isActiveHammer);
    }
    private void Update()
    {
        if(Input.GetKeyDown(KeyCode.Alpha1))
        {
            isActivePistol = !isActivePistol;
            if (isActivePistol)
            {
                isActiveRemote = false;
                isActiveHammer = false;
                SetActiveRemote(false);
                SetActiveHammer(false);
                SetActivePistol(true);
            } 
            else
            {
                SetActivePistol(false);
            }  
        }

        if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            isActiveRemote = !isActiveRemote;
            if (isActiveRemote)
            {
                isActiveHammer = false;
                isActivePistol = false;
                SetActiveHammer(false);
                SetActivePistol(false);
                SetActiveRemote(true);
            }   
            else
            {
                SetActiveRemote(false);
            }
        }

        if (Input.GetKeyDown(KeyCode.Alpha3))
        {
            isActiveHammer = !isActiveHammer;
            if (isActiveHammer)
            {
                isActivePistol = false;
                isActiveRemote = false;
                SetActivePistol(false);
                SetActiveRemote(false);
                SetActiveHammer(true);
            } 
            else
            {
                SetActiveHammer(false);
            }   
        }
    }

    private void SetActiveHammer(bool active)
    {
        if(active)
        {
            hammerTransform.gameObject.SetActive(active);
            hammerTransform.DOLocalMoveZ(0.82f, 0.2f).SetEase(hammerEaseMode);
        } 
        else
        {
            hammerTransform.DOLocalMoveZ(0f, 0.2f).SetEase(hammerEaseMode).OnComplete(() =>
            {
                hammerTransform.gameObject.SetActive(active);
            });
        }
    }

    private void SetActiveRemote(bool active)
    {
        if(active)
        {
            remoteTransform.gameObject.SetActive(active);
            remoteTransform.DOLocalMoveY(7.489f, 0.2f).SetEase(remoteEaseMode);
        }
        else
        {
            remoteTransform.DOLocalMoveY(5.5f, 0.2f).SetEase(remoteEaseMode).OnComplete(() =>
            {
                remoteTransform.gameObject.SetActive(active);
            });
        }
    }

    private void SetActivePistol(bool active)
    {
        if(active)
        {
            pistolTransform.gameObject.SetActive(active);
            pistolTransform.DOLocalMoveY(-0.23f, 0.2f).SetEase(pistolEaseMode);
        }  
        else
        {
            pistolTransform.DOLocalMoveY(-1, 0.2f).SetEase(pistolEaseMode).OnComplete(() =>
            {
                pistolTransform.gameObject.SetActive(active);
            });
        }
    }
}
