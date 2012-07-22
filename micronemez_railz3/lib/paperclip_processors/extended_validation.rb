module Paperclip
  module ExtendedValidations
    def self.included(base)
      base.send :extend, ClassMethods
    end
    
    module ClassMethods
      
      ##
      # Validates <attachment> by extension
      # Just provide the <attachment> in the first argument
      # and pass in the options:
      #  - message: to provide a custom message
      #  - extensions: an array of _valid_ extensions
      #
      # Example:
      #  validates_attachment_extension(:avatar, :extensions => %w[jpg png gif])
      #
      # Note: An array of extensions is required, otherwise there is no
      # point in validating by extension.
      def validates_attachment_extension(attachment, options = {})
        
        ##
        # Invokes the *validates_attachment_extension_of_<attachment>*
        # during the validation process
        validate :"validates_attachment_extension_of_#{attachment}"
        
        ##
        # Dynamically defines the *validates_attachment_extension_of_<attachment>* method
        # based on the *validates_attachment_extension* class method you invoke from
        # the model. It will determine if a validation is required depending on whether
        # the record that is being saved is new and has an attachment, or if the record
        # is being updated and the <attachment> is being re-set. Provides a default message,
        # although you can specify your own from the *validates_attachment_extension* method
        define_method "validates_attachment_extension_of_#{attachment}" do
          if send("#{attachment}_requires_validation?")
            unless options[:extensions].include?(send("#{attachment}_extension"))
              errors.add(attachment, options[:message] || "this is an invalid extension, please only use #{options[:extensions].join(", ")}")
            end
          end
        end
        
        ##
        # Dynamically defines a method for the specified attribute <attachment>
        # Returns the extension from this uploaded file (lowercased)
        define_method "#{attachment}_extension" do
          attributes["#{attachment}_file_name"].split('.').last.downcase
        end

        ##
        # Dynamically defines a method that will determine whether the current validation process
        # requires a validation for the (potential) file upload
        define_method "#{attachment}_requires_validation?" do
          if new_record? and !attributes["#{attachment}_file_name"].blank?
            return true
          elsif !new_record? and !changed_attributes.empty?
            return true
          end
          false
        end

      end
    end # ClassMethods
  end # ExtendedValidations
end # Paperclip

##
# Inject Paperclip::ExtendedValidations into ActiveRecord::Base
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send(:include, Paperclip::ExtendedValidations)
end