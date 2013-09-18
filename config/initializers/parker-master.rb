raw_config = File.read(File.join(Rails.root,"/config/parker-master.yml"))
PARKER_MASTER = YAML.load(raw_config)