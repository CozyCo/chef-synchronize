class ChefSync::DataBagItem < ChefSync::ChefResource

	@resource_type = 'data_bag'

	def initialize(data_bag:, **opts)
		@data_bag = data_bag

		super(opts)
	end

	def self.get_local_resources
		local_data_bag_list = self.local_knife.list

		return local_data_bag_list.flat_map do |dbag|
			local_knife.show(dbag).map {|item| {name: item, data_bag: dbag}}
		end
	end

	def resource_path
		return "#{self.class.resource_type}s/#{@data_bag}/#{@name}"
	end

	def get_local_resource
		return self.class.local_knife.show(@data_bag, @name)
	end

	def get_remote_resource
		return self.class.remote_knife.show(@data_bag, @name)
	end

	def upload_resource
		return self.class.remote_knife.upload(@data_bag, @name_with_extension)
	end

end
