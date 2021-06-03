# @summary Configures the chrome policy by managing a policy.json configuration.
#
# @param policy_hash
#   A key / value hash to set the policies settings for chrome.
#   The value should include "" for strings.
#   @see https://cloud.google.com/docs/chrome-enterprise/policies
#
class google_chrome::policy(
  Hash $policy_hash,
){

  $root_dir        = '/etc/opt/chrome/policies'
  $policy_dir      = "${root_dir}/managed"
  $recommended_dir = "${root_dir}/recommended"
  $required_dirs   = ['/etc/opt/chrome',$root_dir, $policy_dir, $recommended_dir]

  unless '/etc/opt' {
    file{'/etc/opt':
      ensure => directory,
      mode   => '0755'
    }
  }

  file{$required_dirs:
    ensure => directory,
    mode   => '0755',
  }

  file{"${policy_dir}/policy.json":
    ensure  => file,
    content => epp('google_chrome/policy.json.epp',{
      policy_hash => $policy_hash,
      keys        => keys($policy_hash),
      key_size    => size(keys($policy_hash)),
    }),
    require => File[$required_dirs],
  }

}
