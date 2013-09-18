raw_config = File.read(File.join(Rails.root,"/config/stacks.yml"))
STACKS = YAML.load(raw_config)[Rails.env].with_indifferent_access