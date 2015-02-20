module Chameleon
  module VM
    module Validator
      def self.perform_index_check!(index, op_name)
        return if index.is_a?(Integer) && index >= 0

        fail Chameleon::VM::InvalidArgumentError,
             %(ERROR while trying to #{op_name} with index '#{index.inspect}',
               type is not valid index (non-negative integer))
      end

      def self.perform_tos_type_check!(engine, type, op_name)
        return if engine.top_of_stack.type == type

        fail Chameleon::VM::CorruptedStackError,
             %(ERROR while trying to #{op_name} '#{engine.top_of_stack.inspect}',
               type is not '#{type}')
      end

      def self.perform_multiple_tos_type_check!(engine, num, type, op_name)
        cells = engine.top_of_stack(num)
        return if cells.all? { |cell| cell_type_matches? cell, type }

        fail Chameleon::VM::CorruptedStackError,
             %(ERROR while trying to #{op_name} '#{cells.map(&:inspect)}',
               type is not '#{type}')
      end

      def self.perform_type_check!(val, type, op_name)
        return if val.is_a? type

        fail Chameleon::VM::InvalidArgumentError,
             %(ERROR while trying to #{op_name} with value '#{val.inspect}',
               type is not '#{type}')
      end

      def self.perform_variable_type_check!(var, type, op_name)
        return if cell_type_matches? var, type

        fail Chameleon::VM::InvalidVariableTypeError,
             %(ERROR while trying to #{op_name} '#{var.inspect}',
               type is not '#{type}')
      end

      def self.cell_type_matches?(cell, type)
        cell.respond_to?(:type) && cell.type == type
      end
    end
  end
end
