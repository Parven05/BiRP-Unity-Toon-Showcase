using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "Entity")]
public class EntityDataSO : ScriptableObject
{
    public string EntityName;
    public float EntityHealth;
    public EntityType EntityType;
    
}
public enum EntityType
{
    Ground,Fly,UnderGround
}
