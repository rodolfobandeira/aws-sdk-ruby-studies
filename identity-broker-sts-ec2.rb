# Documentatio V3
# https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/STS.html

class IdentityBroker
  def initialize(access_key:, secret_access_key:)
    sts = AWS::STS.new(
      access_key_id: access_key,
      secret_access_key: secret_access_key
    )

    # Connects to LDAP. If everything goes well, request temporary token:
    @temporary_session = sts.new_session(duration: 60) # 1 Minute
  end

  def ec2_instances
    ec2 = AWS::EC2.new(@temporary_session.credentials)
    ec2.instances.to_a
  end
end

identity_broker = IdentityBroker.new(
  access_key: 'my_aws_permanent_key',
  secret_access_key: 'my_aws_permanent_secret_key'
)
puts identity_broker.ec2_instances

