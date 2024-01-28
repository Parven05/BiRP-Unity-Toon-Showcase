using System.Linq;
using UnityEngine;
using UnityEngine.AI;

public class GiantRat : BaseEntity
{
    [SerializeField] private Transform projectilePrefab;
    [SerializeField] private Transform projectileSpawnTransform;
    [SerializeField] private float projectileSpeed = 10f;

    [SerializeField] private float patrolRadius = 10f;
    protected override void InitializeStateMachine()
    {
        stateMachine = new StateMachine();
        stateMachine.SetState(new IdleState(this));
    }

    private class IdleState : IState
    {
        private GiantRat owner;
        public IdleState(GiantRat owner)
        {
            this.owner = owner;
        }
        public void Enter()
        {
            Debug.Log("Giant Rat Entered Idle State");
            owner.stateMachine.SetState(new PatrolState(owner));
        }
        public void Update()
        {

        }

        public void Exit()
        {

        }
    }

    private class PatrolState : IState
    {
        private GiantRat owner;
        public PatrolState(GiantRat owner)
        {
            this.owner = owner;
        }
        public void Enter()
        {
            owner.gatheredColloderCount = 0;
            Debug.Log("Giant Rat Entered Patrol");
            SetRandomDestination();
            Debug.Log(owner.gatheredColloderCount);
        }
        public void Update()
        {
            owner.gatheredColloderCount = Physics.OverlapSphereNonAlloc(owner.transform.position, owner.sightRadius,
                                                                        owner.attckableObjColliders ,owner.attackablesLayer);
            //Debug.Log(owner.gatheredColloderCount);
            // Check if reached destination

            if (!owner.agent.pathPending && owner.agent.remainingDistance < 0.1f)
            {
                // If patrol duration reached, set a new destination
                 SetRandomDestination();
            }

            if (owner.gatheredColloderCount > 0)
            {
                // State To Chase the First One Entered Radius
                owner.stateMachine.SetState(new ChasingState(owner));
            }

        }

        private void SetRandomDestination()
        {
            // Set a random destination within the specified radius
            Vector3 randomPosition = GetRandomNavMeshPointWithinRadius(owner.transform.position, owner.patrolRadius);
            owner.agent.SetDestination(randomPosition);
        }

        private Vector3 GetRandomNavMeshPointWithinRadius(Vector3 center, float radius)
        {
            // Generate a random direction within a circle
            Vector2 randomDirection = Random.insideUnitCircle * radius;

            // Convert the 2D random direction to 3D
            Vector3 randomPosition = new Vector3(randomDirection.x, 0f, randomDirection.y) + center;

            // Sample the nearest point on the NavMesh
            NavMesh.SamplePosition(randomPosition, out NavMeshHit hit, radius, NavMesh.AllAreas);

            return hit.position;
        }

        public void Exit()
        {

        }
    }

    private class ChasingState : IState
    {
        private GiantRat owner;
        private Transform target = null;

        private float timer = 0;
        private float timerMax = 0.5f;
        public ChasingState(GiantRat owner)
        {
            this.owner = owner;
        }
        public void Enter()
        {
            Debug.Log("Giant Rat Entered Chasing State");
            target = null;
        }
        public void Update()
        {
            if (target == null)
            {
                var obj = owner.attckableObjColliders
                    .Where(collider => collider != null) // Filter out null colliders
                    .OrderBy(collider => Vector3.Distance(collider.transform.position, owner.transform.position))
                    .FirstOrDefault();

                if (obj != null)
                {
                    target = obj.transform;
                    owner.agent.SetDestination(target.position);
                }
                else
                {
                    Debug.LogWarning("No Nearby Colliders Found By Enemy Set Back to Patrol");
                    owner.stateMachine.SetState(new PatrolState(owner));
                }
            }
            else
            {
                owner.stateMachine.SetState(new PatrolState(owner));
            }


            timer += Time.deltaTime;
            if (timer > timerMax)
            {
                owner.agent.SetDestination(target.position);
                timer = 0;
            }

            //Debug.Log($"Robo to body Dis {owner.agent.remainingDistance}");
            if (owner.agent.remainingDistance < owner.attackRadius)
            {
                Debug.Log("Reached Target need To Change attack State");
                owner.stateMachine.SetState(new AttackState(owner,target));
            }

        }

        public void Exit()
        {
        }
    }

    private class AttackState : IState
    {
        private GiantRat owner;
        private Transform target;

        private float timer = 0;
        private float timerMax = 1.5f;

        public AttackState(GiantRat owner, Transform target)
        {
            this.owner = owner;
            this.target = target;
        }

        public void Enter()
        {
            Debug.Log("Giant Rat Entered Attack State");
            SpawnProjectile();
        }

        public void Update()
        {
            timer += Time.deltaTime;
            if (timer > timerMax)
            {
                if(Vector3.Distance(owner.transform.position,target.position) < owner.attackRadius)
                {
                    SpawnProjectile();
                }
                else
                {
                    owner.stateMachine.SetState(new ChasingState(owner));
                }
                
                timer = 0;
            }

            //owner.transform.LookAt(target);
        }

        private void SpawnProjectile()
        {
            Transform prefabSpawned = Instantiate(owner.projectilePrefab, owner.projectileSpawnTransform.position, Quaternion.identity);

            Vector3 direction = target.position - owner.projectileSpawnTransform.position;
            direction.Normalize(); // Ensure the direction is normalized

            Rigidbody projectileRb = prefabSpawned.GetComponent<Rigidbody>();
            projectileRb.AddForce(direction * owner.projectileSpeed, ForceMode.Impulse);
        }

        public void Exit()
        {
            // You can add exit logic if needed
        }
    }

}
