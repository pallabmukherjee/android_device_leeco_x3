############################ This is for NOS #####################################
# x3
	if [ $configb = "x3" ]; then
		if [ -d device/leeco/x3 ]; then
			cd device/leeco/x3
			git pull -f
			cd ~/$nitrogen_dir
		else
			repo_clone
		fi

		if [ -d kernel/leeco/x3 ]; then
			cd kernel/leeco/x3
			git pull -f
			cd ~/$nitrogen_dir
		else
			repo_clone
		fi

		if [ -d vendor/leeco ]; then
			cd vendor/leeco
			git pull -f
			cd ~/$nitrogen_dir
		else
			repo_clone
		fi
	fi
  
  if [ $configb = "x3" ]; then
		if ! [ -d device/leeco/x3 ]; then
			echo -e "${bldred}N4: No device tree, downloading...${txtrst}"
			git clone https://github.com/joshi3/android_device_leeco_x3.git -b nos device/leeco/x3
		fi
		if ! [ -d kernel/leeco/x3 ]; then
			echo -e "${bldred}N4: No kernel sources, downloading...${txtrst}"
			git clone https://github.com/joshi3/Psycho-Kernel.git -b master kernel/leeco/x3
		fi
		if ! [ -d vendor/leeco/x3 ]; then
			echo -e "${bldred}N4: No vendor, downloading...${txtrst}"
			git clone https://github.com/joshi3/proprietary_vendor_leeco.git -b master vendor/leeco
		fi
	fi
  
  7. x3
  8. Abort
  
  	7 )
		configb=x3
		break
		;;
	8 )
		break
		;;
