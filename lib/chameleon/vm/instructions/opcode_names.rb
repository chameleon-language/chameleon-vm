module Chameleon
  # Virtual Machine
  module VM
    # input-output
    I_GETS          = 10
    I_PUTS          = 11

    # typecasts
    I_TOS           = 20
    I_TOI           = 21

    # push constant
    I_PUSH_INT      = 30
    I_PUSH_STRING   = 31

    # arithmetics
    I_ADD           = 40
    I_MULTIPLY      = 42

    # variables
    I_STORE_INT_VAR = 50
    I_LOAD_INT_VAR  = 70
    I_INCR_INT_VAR  = 80

    # flow control
    I_GOTO          = 66
    I_GOTO_IF_LESS  = 67
  end
end
