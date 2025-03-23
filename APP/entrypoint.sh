#!/bin/sh

set -e  # Exit script on error

handle_error() {
  case "$1" in
    *"os error 17"*)
      echo "\t\e[31m❌ \e[1m Error:\e[0m The directory already exists. Please check if the workspace is already created."
      ;;
    *"os error 2"*)
      echo "\t\e[32m✅ \e[1mSuccess:\e[0m Workspace Created successfully."
      ;;
    *)
      echo "\t\e[31m❌ An unexpected error occurred: $1\e[0m"
      ;;
  esac
  exit 1
}


COMMAND=$1
WORKSPACE=$2
PROGRAM=$3

if [ -z "$COMMAND" ]; then
    echo "Error: No command provided."
    echo "Available commands: new-workspace, new-program, build-workspace, build-program, test-workspace, test-program"
    exit 1
fi

case "$COMMAND" in
    new-workspace)
        if [ -z "$WORKSPACE" ]; then
            echo "Error: No workspace name provided."
            echo "Usage: docker compose run --rm solana-anchor new-workspace <workspace-name>"
            exit 1
        fi
        echo "Creating new Anchor workspace: [[ \e[33m\e[1m$WORKSPACE\e[0m ]]"
        # Add command here to create workspace
        ERROR_OUTPUT=$(anchor init "$WORKSPACE" --no-git 2>&1) || handle_error "$ERROR_OUTPUT";;
    
    new-program)
        if [ -z "$WORKSPACE" ] || [ -z "$PROGRAM" ]; then
            echo "\t\e[31m❌\e[1m Error:\e[0m Missing parameters."
            echo "\t\e[32m\e[1mUsage:\e[0m docker compose run --rm solana-anchor new-program <workspace-name> <program-name>"
            exit 1
        fi
        echo "Creating new program {{ \e[36m\e[1m$PROGRAM\e[0m }} in workspace [[ \e[33m\e[1m$WORKSPACE\e[0m ]]"
        # Add command here to create program in workspace
        cd $WORKSPACE 2>/dev/null || { echo "\t\e[31m❌ \e[1mFailed:\e[0m No workspace named \e[33m\e[1m$WORKSPACE\e[0m"; exit 1; } && \
        anchor new $PROGRAM 2>/dev/null 1>/dev/null || { echo "\t\e[31m❌ \e[1mError:\e[0m Program already exists"; exit 1; } && \
        echo "\t\e[32m✅ Success:\e[0m Program {{ \e[36m\e[1m$PROGRAM\e[0m }} created successfully";;
    
    build-workspace)
        if [ -z "$WORKSPACE" ]; then
            echo "\t\e[31m❌\e[1m Error:\e[0m No workspace name provided."
            echo "\t\e[32m\e[1mUsage:\e[0m docker compose run --rm solana-anchor build-workspace <workspace-name>"
            exit 1
        fi
        echo "    Building workspace: [[ \e[33m\e[1m$WORKSPACE\e[0m ]]"
        # Add command here to build the entire workspace
        cd $WORKSPACE 2>/dev/null || { echo "\t\e[31m❌ \e[1mFailed:\e[0m No workspace named [[ \e[33m\e[1m$WORKSPACE\e[0m ]]"; exit 1; } && \
        cargo update bytemuck_derive@1.9.2 --precise 1.8.1 2>/dev/null || echo "✅ Using bytemuck_derive@1.8.1" && \
        anchor build 2>&1 || { echo "\t\e[31m❌\e[1m Failed:\e[0m An unexpected error occurred."; exit 1; } && \
        echo "\t\e[32m✅ Success:\e[0m Workspace [[ \e[33m\e[1m$WORKSPACE\e[0m ]] build successfully";;
    
    build-program)
        if [ -z "$WORKSPACE" ] || [ -z "$PROGRAM" ]; then
            echo "Error: Missing parameters."
            echo "Usage: docker compose run --rm solana-anchor build-program <workspace-name> <program-name>"
            exit 1
        fi
        echo "🛠️🛠️🛠️ Building program {{ \e[1m$PROGRAM\e[0m }} in workspace  [[ \e[1m$WORKSPACE\e[0m ]]"
        # Add command here to build a single program
        cd $WORKSPACE 2>/dev/null || { echo "❌ Failed: No workspace named \e[1m$WORKSPACE\e[0m"; exit 1; } && \
        cargo update bytemuck_derive@1.9.2 --precise 1.8.1 2>/dev/null || echo "✅ Using bytemuck_derive@1.8.1" && \
        anchor build --program-name $PROGRAM 2>&1 || echo "❌ Failed: An unexpected error occurred.";;
    
    test-workspace)
        if [ -z "$WORKSPACE" ]; then
            echo "Error: No workspace name provided."
            echo "Usage: docker compose run --rm solana-anchor test-workspace <workspace-name>"
            exit 1
        fi
        echo "Testing workspace: 🏢🛠️ $WORKSPACE"
        # Add command here to test the entire workspace
        cd $WORKSPACE && \
        cargo update bytemuck_derive@1.9.2 --precise 1.8.1 2>/dev/null || echo "✅ Using bytemuck_derive@1.8.1" && \
        anchor test;;
    
    test-program)
        if [ -z "$WORKSPACE" ] || [ -z "$PROGRAM" ]; then
            echo "Error: Missing parameters."
            echo "Usage: docker compose run --rm solana-anchor test-program <workspace-name> <program-name>"
            exit 1
        fi
        echo "Testing program 🖥️📜'$PROGRAM' in workspace 🏢🛠️ '$WORKSPACE'"
        # Add command here to test a single program
        cd $WORKSPACE && \
        cargo update bytemuck_derive@1.9.2 --precise 1.8.1 2>/dev/null || echo "✅ Using bytemuck_derive@1.8.1" && \
        anchor test --program-name $PROGRAM 2>&1 || echo "❌ Failed: An unexpected error occurred.";;
    
    *)
        echo "Error: Invalid command '$COMMAND'."
        echo "Available commands: new-workspace, new-program, build-workspace, build-program, test-workspace, test-program"
        exit 1
        ;;
esac


































# #!/bin/sh

# COMMAND=$1
# SUBCOMMAND=$2

# if [ -z "$COMMAND" ]; then
#     echo "Error: No command provided. Available commands: new, new-program, test"
#     exit 1
# fi

# case "$COMMAND" in
#     new)
#         echo "Creating new Anchor workspace..."
#         anchor init $SUBCOMMAND --no-git ;;
#     newprogram)
#         echo "Creating a new program..."
#         cd projectdir && anchor new $SUBCOMMAND ;;
#     test)
#         echo "Running tests..."
#         cd projectdir && anchor test ;;
#     *)
#         echo "Error: Invalid command '$COMMAND'. Available commands: new, new-program, test"
#         exit 1 ;;
# esac
