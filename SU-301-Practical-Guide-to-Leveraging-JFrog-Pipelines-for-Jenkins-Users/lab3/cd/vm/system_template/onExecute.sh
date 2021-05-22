
deployWebApp() {
    local success=true
    local deploy_mode=""

    local dry_run=$(find_step_configuration_value "dryRun")
    local comment=$(find_step_configuration_value "comment")

    local web_app=$(find_step_configuration_value "webApp")
    local container=$(find_step_configuration_value "container")
    local ansible_deploy=$(find_step_configuration_value "ansible")

    local role=`echo $ansible_deploy | jq -r ".role"`
    local inventory=`echo $ansible_deploy | jq -r ".inventory"`

    local repo=`echo $container | jq -r ".repo"`
    local tag=`echo $container | jq -r ".tag"`

    local path=`echo $web_app | jq -r ".path"`
    local technology=`echo $web_app | jq -r ".technology"`

    local webhook_rsc_name=$(get_resource_name --type IncomingWebhook --operation IN)
    echo "Webhook name: $webhook_rsc_name"

    local payload=$(find_resource_variable $webhook_rsc_name payload)
    echo "Webhook payload: $payload"

    local vm_rsc_name=$(get_resource_name --type VmCluster --operation IN)
    echo "VM Cluster name: $vm_rsc_name"

    local sshkey=$(find_resource_variable $vm_rsc_name sshKey)
    echo "SSH Key name: $sshkey"

    local ips=$(find_resource_variable $vm_rsc_name targets)
    echo "target IPs : $ips"

    echo "Dry run mode : $dry_run"
    echo "Comment : $comment"

    echo "Webapp: $webapp"
    echo "path: $path"
    echo "technology: $path"

    if [ -n $webapp ]; then
        deploy_mode="WebApp"
    else 
        
    fi

    echo "Container info: $container"
    echo "repo: $repo"
    echo "tag: $tag"

    if [  -z $deploy_mode ]; then
        deploy_mode="Container"
    else
        success=false
        echo "[ERROR] You can choose only 1 deployment type"
    fi   

    echo "Ansible info : $ansible_deploy"
    echo "role : $role"
    echo "inventory : $inventory"

    if [  -z $deploy_mode ]; then
        deploy_mode="Ansible"
    else
        success=false
        echo "[ERROR] You can choose only 1 deployment type"
    fi   

    if [ $success == "true" ]; then

        echo "[INFO] Starting $deploy_mode deployment ..."
        
        for curr_ip in `echo $ips | jq -r '.[]'`; do
            echo ${curr_ip}
            ssh -i ~/.ssh/${vm_rsc_name} ec2-user@${curr_ip} "./deploy.sh $deploy_mode"
        fi

        echo "[INFO] Deployment done"
    done


    $success
}
 
execute_command deployWebApp