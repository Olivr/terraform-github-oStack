# ---------------------------------------------------------------------------------------------------------------------
# Resources
# ---------------------------------------------------------------------------------------------------------------------
module "backends_namespaces_tfe" {
  source = "Olivr/backend/tfe"

  for_each   = local.backends_namespaces_tfe
  depends_on = [local.vcs_repos_namespaces]

  sensitive_inputs       = each.value.sensitive_inputs
  tfe_oauth_token_id     = each.value.tfe_oauth_token_id
  vcs_branch_name        = local.namespaces_repos_static[each.value.repo_id].vcs.branch_default_name
  vcs_repo_path          = local.namespaces_repos_static[each.value.repo_id].vcs.full_name
  vcs_working_directory  = each.value.vcs_working_directory
  vcs_trigger_paths      = each.value.vcs_trigger_paths
  workspace_auto_apply   = each.value.auto_apply
  workspace_description  = each.value.description
  workspace_env_vars     = each.value.env_vars
  workspace_name         = each.value.name
  workspace_organization = local.backend_organization_name
  workspace_tf_vars      = each.value.tf_vars
  workspace_tf_vars_hcl  = each.value.tf_vars_hcl
}

module "backends_globalops_tfe" {
  source = "Olivr/backend/tfe"

  for_each   = local.backends_globalops_tfe
  depends_on = [local.vcs_repo_globalops]

  sensitive_inputs       = local.globalops_dynamic.backends[each.key].sensitive_inputs
  tfe_oauth_token_id     = local.globalops_static.backends[each.key].tfe_oauth_token_id
  vcs_branch_name        = local.globalops_static.vcs.branch_default_name
  vcs_repo_path          = local.globalops_static.vcs.full_name
  vcs_working_directory  = local.globalops_static.backends[each.key].vcs_working_directory
  vcs_trigger_paths      = local.globalops_static.backends[each.key].vcs_trigger_paths
  workspace_auto_apply   = local.globalops_static.backends[each.key].auto_apply
  workspace_description  = local.globalops_static.backends[each.key].description
  workspace_env_vars     = local.globalops_static.backends[each.key].env_vars
  workspace_name         = local.globalops_static.backends[each.key].name
  workspace_organization = local.backend_organization_name
  workspace_tf_vars      = local.globalops_static.backends[each.key].tf_vars
  workspace_tf_vars_hcl  = local.globalops_dynamic.backends[each.key].tf_vars_hcl
}
