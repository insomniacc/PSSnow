function Get-SNOWChangeRequest {
                <#
                .SYNOPSIS
                    Retrieves a change_request record from SNOW
                .DESCRIPTION
                    Gets a record from the change_request table
                .NOTES
                    Uses Get-SNOWObject as a template function.
                .OUTPUTS
                    PSCustomObject. The full table record/s.
                .LINK
                    https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html
                .EXAMPLE
                    Get-SNOWChangeRequest -limit 1 -verbose
                    Returns a single record from change_request
                #>   
            
                [CmdletBinding()]
                param (
                    [Parameter()]
                    [string]
                    $number,
                    [Parameter()]
                    [string]
                    $requested_by,
                    [Parameter()]
                    [string]
                    $category,
                    [Parameter()]
                    [alias('service')]
                    [string]
                    $business_service,
                    [Parameter()]
                    [string]
                    $service_offering,
                    [Parameter()]
                    [alias('configuration_item')]
                    [string]
                    $cmdb_ci,
                    [Parameter()]
                    [string]
                    $priority,
                    [Parameter()]
                    [string]
                    $risk,
                    [Parameter()]
                    [string]
                    $impact,
                    [Parameter()]
                    [alias('model')]
                    [string]
                    $chg_model,
                    [Parameter()]
                    [string]
                    $type,
                    [Parameter()]
                    [string]
                    $state,
                    [Parameter()]
                    [boolean]
                    $on_hold,
                    [Parameter()]
                    [string]
                    $conflict_status,
                    [Parameter()]
                    [string]
                    $assignment_group,
                    [Parameter()]
                    [string]
                    $assigned_to,
                    [Parameter()]
                    [string]
                    $short_description,
                    [Parameter()]
                    [boolean]
                    $cab_required,
                    [Parameter()]
                    [string]
                    $cab_delegate,
                    [Parameter()]
                    [string]
                    $cab_recommendation,
                    [Parameter()]
                    [string]
                    $close_code,
                    [Parameter()]
                    [string]
                    $on_hold_task,
                    [Parameter()]
                    [boolean]
                    $production_system,
                    [Parameter()]
                    [string]
                    $opened_by,
                    [Parameter()]
                    [string]
                    $closed_by,
                    [Parameter()]
                    [boolean]
                    $active,
                    [Parameter()]
                    [string]
                    $approval,
                    [Parameter()]
                    [string]
                    $parent,
                    [Parameter()]
                    [string]
                    $phase,
                    [Parameter()]
                    [string]
                    $phase_state,
                    [Parameter()]
                    [boolean]
                    $unauthorized,
                    [Parameter()]
                    [string]
                    $company,
                    [Parameter()]
                    [string]
                    $escalation,
                    [Parameter()]
                    [string]
                    $location,
                    [Parameter()]
                    [boolean]
                    $made_sla          
                )
                DynamicParam { Import-DefaultParams -TemplateFunction "Get-SNOWObject" }
            
                Begin {
                    $table = "change_request"
                }
                Process {
                    Invoke-SNOWTableREAD -table $table -Parameters $PSBoundParameters
                }
            }
