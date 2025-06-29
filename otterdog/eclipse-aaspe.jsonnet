local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('dt.aaspe', 'eclipse-aaspe') {
  settings+: {
    description: "C# based viewer & editor for the Asset Administration Shell",
    name: "Eclipse AASX Package Explorer and Server",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "write",
    },
  },
  _repositories+:: [
    orgs.newRepo('common') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "aaspe common components",
      has_wiki: false,
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('package-explorer') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages+: [
        "javascript-typescript",
      ],
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: false,
      description: "AASX Package Explorer",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      secrets: [
        orgs.newRepoSecret('SECRET1') {
          value: "********",
        },
      ],
    },
    orgs.newRepo('server') {
      aliases: ['aasx-server'],
      allow_rebase_merge: false,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "C# based server for AASX packages",
      homepage: "",
      topics+: [
        "aasx",
        "aasx-server",
        "administration-shell",
        "asset-administration-shell",
        "industrie-40",
        "industrie40"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://cla-assistant.io/github/webhook/aasx-server') {
          content_type: "json",
          events+: [
            "pull_request"
          ],
        },
      ],
      secrets: [
        orgs.newRepoSecret('DOCKERHUB_PASSWORD') {
          value: "********",
        },
      ],
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          required_approving_review_count: null,
          required_status_checks+: [
            "any:Check-release",
            "any:Check-style"
          ],
          requires_pull_request: false,
        },
      ],
    },
  ],
} + {
  # snippet added due to 'https://github.com/EclipseFdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}