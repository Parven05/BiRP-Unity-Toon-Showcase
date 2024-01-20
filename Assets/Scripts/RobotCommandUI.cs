using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class RobotCommandUI : MonoBehaviour
{
    [SerializeField] private Transform commandButtonsUIParent;
    private RobotMovement robotMovement;
    [SerializeField] private Button getInTruckButton;
    [SerializeField] private Button followMeButton;
    [SerializeField] private Button stayHereButton;
    [SerializeField] private Button defenceTruckButton;

    private void Awake()
    {
        robotMovement = FindObjectOfType<RobotMovement>();

        getInTruckButton.onClick.AddListener(() =>
        {
            GetInTruck();
        });

        followMeButton.onClick.AddListener(() =>
        {
            FollowMe();
        });

        stayHereButton.onClick.AddListener(() =>
        {
            StayHere();
        });

        defenceTruckButton.onClick.AddListener(() =>
        {
            DefenceTruck();
        });
    }

    private void Update()
    {
        if (commandButtonsUIParent.gameObject.activeSelf)
        {
            Cursor.lockState = CursorLockMode.None;
        }

    }

    private void DefenceTruck()
    {
        robotMovement.SetTargetTruckGunPosition();
        defenceTruckButton.interactable = false;
        followMeButton.interactable = true;
        getInTruckButton.interactable = true;
        stayHereButton.interactable = true;

        CloseUI();
    }
    private void FollowMe()
    {
        robotMovement.SetPlayerAsTargetToRobot();
        followMeButton.interactable = false;
        getInTruckButton.interactable = true;
        stayHereButton.interactable = true;
        defenceTruckButton.interactable = true;

        CloseUI();
    }
    private void GetInTruck()
    {
        robotMovement.SetTruckAsTargetToRobot();
        followMeButton.interactable = true;
        getInTruckButton.interactable = false;
        stayHereButton.interactable = true;
        defenceTruckButton.interactable = true;

        CloseUI();
    }
    private void StayHere()
    {
        Debug.Log("Ok Im Stay Here ");
        robotMovement.SetTargetNull();
        followMeButton.interactable = true;
        getInTruckButton.interactable = true;
        stayHereButton.interactable= false;
        defenceTruckButton.interactable = true;

        CloseUI();
    }

    public void CloseUI()
    {
        Hide();
        Cursor.lockState = CursorLockMode.Locked;
    }

    public void Show()
    {
        commandButtonsUIParent.gameObject.SetActive(true);
    }

    private void Hide()
    {
        commandButtonsUIParent.gameObject.SetActive(false);
    }
}
