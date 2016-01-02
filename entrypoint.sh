#!/bin/bash
set -e
source ${INVOICEPLANE_RUNTIME_DIR}/functions

case ${1} in
  app:invoiceplane|app:nginx)

    initialize_system

    case ${1} in
      app:invoiceplane)
        configure_invoiceplane
        echo "Starting InvoicePlane php5-fpm..."
        exec $(which php5-fpm)
        ;;
      app:nginx)
        configure_nginx
        echo "Starting nginx..."
        exec $(which nginx) -c /etc/nginx/nginx.conf -g "daemon off;"
        ;;
    esac
    ;;
  app:help)
    echo "Available options:"
    echo " app:invoiceplane     - Starts the InvoicePlane php5-fpm server (default)"
    echo " app:nginx            - Starts the nginx server"
    echo " app:help             - Displays the help"
    echo " [command]            - Execute the specified command, eg. bash."
    ;;
  *)
    exec "$@"
    ;;
esac
