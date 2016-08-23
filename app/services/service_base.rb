class ServiceBase
  private_class_method :new

  def self.run(*args)
    new(*args).run
  end
end
