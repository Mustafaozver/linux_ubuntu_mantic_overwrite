 #!/bin/bash

# Obtener el porcentaje de uso de la RAM
total=$(free | awk '/^Mem:/{print $2}')
used=$(free | awk '/^Mem:/{print $3}')
percentage=$(echo "scale=2; $used / $total * 100" | bc -l)

echo $percentage
