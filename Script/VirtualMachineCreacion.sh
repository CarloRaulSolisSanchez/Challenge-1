while true; do
    echo "Virtual Machine - Creacion"
    echo ""
    echo "1- Crear Virtual Machine"
    echo "2- Lista de Virtual Machines"
    echo "3- Delete Virtual Machine"
    echo "0- Salir"
    echo ""
    read -p "OPC: " option

    case "$option" in
        1)
            echo ""
            echo ""
            echo "[CREAR MAQUINA VIRTUAL]"
            echo ""
            read -p "Nombre (MV): " vm_name
            read -p "Tipo de Sistema Operativo: " operative_system_type
            VBoxManage createvm --name "$vm_name" --register --ostype "$operative_system_type"

            echo ""
            echo ""            

            read -p "CPU: " cpu
            read -p "RAM(GB): " ram
            read -p "VRAM: " vram
            VBoxManage modifyvm "$vm_name" --cpus "$cpu" --memory "$((ram * 1024))" --vram "$vram"
            

            echo ""
            echo ""

            read -p "Tamano del Disco Duro(GB): " hard_disk
            VBoxManage createhd --filename "${vm_name}".vdi --size "$((hard_disk * 1024))"

            echo ""
            echo ""

            read -p "Controlador SATA: " sata_driver
            VBoxManage storagectl "$vm_name" --name "$sata_driver" --add sata --bootable on
            VBoxManage storageattach "$vm_name" --storagectl "$sata_driver" --port 0 --device 0 --type hdd --medium "${vm_name}.vdi"


            echo ""
            echo ""

            read -p "Controlador IDE: " ide_driver
            VBoxManage storagectl "$vm_name" --name "$ide_driver" --add ide
            VBoxManage storageattach "$vm_name" --storagectl "$ide_driver" --port 0 --device 0 --type dvddrive --medium ./home/user/dvd.iso

            echo ""
            echo ""
            echo ""
            echo ""
        
            echo "Virtul Machine - INFO"
            VBoxManage showvminfo "$vm_name"
            echo ""
            echo ''

        ;;
        2)
            echo ""
            echo ""
            echo "[LISTA DE MAQUINAS VIRTUALES]"
            VBoxManage list vms
            echo ""
            echo ""
        ;;
        3)
            echo ""
            echo ""
            echo "[BORRAR MAQUINAS VIRTUALES]"
            echo ""
            read -p "Maquina Virtual a borrar: " vn_name_to_delete
            VBoxManage unregistervm --delete "$vn_name_to_delete"
            echo ""
            echo ""
            echo "Maquina con el nombre $vn_name_to_delete eliminada"
            echo ""
            echo "" 
        ;;
        0)
            echo ""
            echo ""            
            echo "SALIENDO..."
            break
        ;;
        
        *)
            echo ""
            echo ""
            echo "OPCION INVALIDA..............."
            echo ""
            echo ""
        ;;
    esac
done
