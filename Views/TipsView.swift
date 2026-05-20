import SwiftUI

struct TipsView: View {
    @EnvironmentObject var vm: ViewModel

    var body: some View {
        ZStack {
            ScrollView {
                VStack {

                    if !vm.predictionText.contains("Analyzing") {
                        Text("Tips for: \(vm.predictionText)")
                            .font(.system(size: 24, weight: .medium, design: .default))
                            .foregroundColor(.black)
                            .padding(.top, 25)
                            .padding(.bottom, 10)

                        Text(tipsGrabber(for: vm.predictionText))
                            .padding()
                            .opacity(vm.predictionText.isEmpty ? 0 : 1)
                            .transition(.opacity.animation(.easeInOut(duration: 0.5)))
                    } else {
                        Text(vm.predictionText)
                            .font(.system(size: 24, weight: .medium, design: .default))
                            .foregroundColor(.black)
                            .padding(.top, 25)
                            .padding(.bottom, 10)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        Spacer()
    }
}

enum Tips {
    case motherboard
    case cpu
    case gpu
    case ram
    case hdd
    case monitor
    case powerSupply
    case case_
    case keyboard
    case mouse
    case cables
    case webcam

    var description: String {
        switch self {
        case .motherboard:
            return """
            The motherboard serves as the central nervous system of your computer, connecting and enabling communication between all other components. Proper installation is crucial for system stability and longevity.

            1.  Preparation and Anti-Static Measures: Before handling the motherboard, ground yourself to prevent electrostatic discharge (ESD) which can severely damage sensitive components. Work on a clean, non-conductive surface, such as the motherboard box or an anti-static mat.

            2.  Installing the CPU: Carefully open the CPU socket lever. Align the CPU's orientation markings (usually a triangle on one corner) with the corresponding mark on the socket. Gently place the CPU into the socket without applying any force. Once seated correctly, close and secure the lever.

            3.  Installing RAM Modules: Open the retaining clips on the RAM slots. Align the notch on the RAM module with the notch in the slot. Press down firmly and evenly on both ends of the RAM stick until the retaining clips snap into place, securing the module.

            4.  Installing Motherboard Standoffs: Before placing the motherboard in the case, you must install the motherboard standoffs into the computer case. These small, screw-like posts create a crucial gap between the motherboard's circuitry and the metal case, preventing short circuits. The standoffs screw into designated holes in the case. Refer to your case manual for the correct locations.

            5.  Mounting in the Case: Carefully align the screw holes on the motherboard with the installed standoffs in the case. Secure the motherboard to the standoffs using screws. Do not overtighten.

            6.  Installing the I/O Shield: Before mounting the motherboard, ensure the I/O (Input/Output) shield is correctly installed in the back of the case. Align it properly with the motherboard's ports.

            7.  Connecting Power Cables: Connect the main 24-pin ATX power connector and the 4-pin or 8-pin EPS (CPU power) connector from the power supply to the motherboard. Ensure they are firmly seated.

            8.  Connecting Case Headers: Refer to your motherboard manual to connect the front panel connectors from your case (power button, reset button, USB ports, audio jacks, etc.) to the corresponding pins on the motherboard. Polarity matters for some connectors like power and reset LEDs.

            9.  BIOS/UEFI Update: After the initial boot, it's often recommended to check for and update to the latest BIOS/UEFI firmware from the motherboard manufacturer's website. This can improve compatibility and performance.
            """
        case .cpu:
            return """
            The Central Processing Unit (CPU) is the brain of your computer, responsible for executing instructions and performing calculations. Careful installation is essential to avoid damage and ensure proper cooling.

            1.  Preparation and Orientation: Handle the CPU by its edges to avoid touching the pins or contact pads. Identify the orientation markings on the CPU (usually a triangle or an arrow) and the corresponding mark on the CPU socket.

            2.  Socket Lever Operation: Gently open the lever on the CPU socket. Align the CPU with the socket, ensuring the orientation markings match. Carefully place the CPU into the socket. It should sit flush without any force.

            3.  Securing the CPU: Once the CPU is correctly seated, close the socket lever to secure it in place. The lever might require a slight amount of pressure to close fully.

            4.  Applying Thermal Paste: A crucial step for heat transfer. Apply a small, pea-sized amount of high-quality thermal paste to the center of the CPU's integrated heat spreader (IHS). The goal is to create a thin, even layer between the CPU and the cooler.

            5.  Installing the CPU Cooler: Align the CPU cooler with the mounting holes on the motherboard. Depending on the cooler type, you might need to use mounting brackets. Secure the cooler firmly, ensuring even pressure across the CPU. Do not overtighten, as this can damage the motherboard or CPU.

            6.  Connecting Cooler Power: If your CPU cooler has a fan, connect its power cable to the designated CPU fan header on the motherboard.

            7.  First Boot and Temperature Monitoring: After the initial system boot, enter the BIOS/UEFI settings to monitor the CPU temperature. Ensure it's within the safe operating range specified by the manufacturer. Overheating can lead to performance issues and damage.
            """

        case .gpu:
            return """
            The Graphics Processing Unit (GPU) is responsible for rendering images, videos, and other visual content on your computer. Proper installation ensures optimal performance for gaming, video editing, and other graphically intensive tasks.

            1.  Preparation and Slot Identification: Identify the primary PCIe x16 slot on your motherboard. It's usually a longer slot and often a different color than the others. Ensure your computer is powered off and unplugged before installation.

            2.  Case Modification (if necessary): Some larger GPUs may require the removal of one or more rear case slot covers to accommodate their size. Remove the appropriate covers.

            3.  Inserting the GPU: Align the gold connector pins on the GPU with the PCIe x16 slot. Press down firmly and evenly on the top edge of the card until it clicks into place. You should hear or feel the retention clip on the slot engage.

            4.  Securing the GPU: Secure the GPU to the case using screws through the mounting bracket at the rear of the case. This prevents the card from moving or sagging, especially for heavier GPUs.

            5.  Connecting Power Cables: Many modern GPUs require additional power directly from the power supply. Check the GPU's manual for the type and number of PCIe power connectors (6-pin or 8-pin) needed and connect them securely.

            6.  Installing Drivers: After booting up your computer, you'll need to install the latest drivers for your specific GPU model from the manufacturer's website (NVIDIA or AMD). These drivers enable the GPU's full features and ensure compatibility with your operating system and applications.

            7.  Monitoring Performance and Temperature: After installation, monitor the GPU's performance and temperature, especially during demanding tasks. Ensure adequate airflow in your case to prevent overheating.
            """

        case .ram:
            return """
            Random Access Memory (RAM) provides fast, temporary storage for data that your computer is actively using. Installing RAM correctly ensures optimal system performance and stability.

            1.  Motherboard Manual Consultation: Refer to your motherboard manual to identify the correct RAM slots to use based on the number of modules you are installing and whether you want to enable dual-channel or quad-channel configurations. The manual will specify which slots to populate first.

            2.  Opening the Retention Clips: Locate the RAM slots on your motherboard. These slots have retention clips at one or both ends. Gently push down or pull outwards on these clips to open them.

            3.  Aligning the RAM Module: Observe the notch (or notches) on the edge of the RAM module's connector pins. This notch must align with the corresponding key (or keys) within the RAM slot. Do not try to force the RAM in if it doesn't align easily.

            4.  Inserting the RAM Module: Once aligned, press down firmly and evenly on both ends of the RAM stick. You should feel and hear the module click into place as the retention clips snap closed, securing the RAM in the slot. Ensure the clips are fully engaged.

            5.  Reseating if Issues Arise: If your system fails to boot or doesn't recognize the installed RAM, power off the computer, unplug it, and try reseating the RAM modules. Ensure they are firmly in their slots.

            6.  Enabling XMP/DOCP (Optional): In the BIOS/UEFI settings, you may find options to enable XMP (Intel) or DOCP (AMD) profiles. These profiles allow your RAM to run at its advertised speeds and timings. Consult your motherboard and RAM documentation for details.

            7.  Avoiding Contact with Gold Pins: Handle RAM modules by their edges to avoid touching the gold connector pins, as oils and static can damage them.
            """
        case .hdd:
            return """
            A Hard Disk Drive (HDD) is a traditional storage device that stores data magnetically. Proper installation involves secure mounting and correct cable connections.

            1.  Mounting the Drive: Locate an available 3.5-inch drive bay in your computer case. Slide the HDD into the bay and secure it with screws on both sides. Ensure it's firmly mounted to prevent vibration and potential damage.

            2.  Connecting SATA Data Cable: Connect one end of a SATA (Serial ATA) data cable to one of the SATA ports on your motherboard. Connect the other end of the SATA data cable to the SATA data port on the back of the HDD.

            3.  Connecting SATA Power Cable: Connect a SATA power cable from your power supply to the SATA power connector on the back of the HDD. Ensure it's a snug fit.

            4.  First Boot and Formatting: After the initial boot, the operating system may not immediately recognize the new HDD. You might need to go into Disk Management (Windows) or Disk Utility (macOS) to initialize and format the drive before you can use it for storage.

            5.  Data Transfer (if applicable): If you are replacing an old drive, you may need to transfer your data to the new HDD using cloning software or by manually copying files.
            """
        case .monitor:
            return """
            A monitor is the primary output device that displays visual information from your computer. Setting it up usually involves connecting cables.

            1.  Cable Connection: Identify the appropriate video output port on your computer's graphics card (or motherboard if you don't have a dedicated GPU). Common ports include HDMI, DisplayPort, DVI, and VGA. Connect the corresponding video cable from your monitor to this port.

            2.  Power Connection: Connect the monitor's power cable to a power outlet and to the power input on the monitor.

            3.  Powering On: Turn on the monitor and then your computer.

            4.  Adjusting Settings: Once the computer has booted, you may need to adjust the monitor's settings (resolution, brightness, contrast, refresh rate) through the monitor's on-screen display (OSD) or through your operating system's display settings.

            5.  Driver Installation (if necessary): In some cases, especially for high-end monitors, you might need to install specific drivers from the manufacturer's website for full functionality.
            """
        case .powerSupply:
            return """
            The Power Supply Unit (PSU) provides the necessary electrical power to all the components in your computer. Choosing the right wattage and installing it correctly is crucial for system stability and preventing damage.

            1.  Mounting in the Case: Locate the designated PSU bay in your computer case. Place the power supply in the bay, ensuring the fan orientation is correct (usually facing downwards or upwards depending on the case design). Secure it with screws.

            2.  Connecting to the Motherboard: Connect the main 24-pin ATX power connector to the corresponding connector on the motherboard. Also, connect the 4-pin or 8-pin EPS (CPU power) connector to the motherboard. These are essential for powering the core components.

            3.  Connecting to Other Components: Connect the appropriate PCIe power cables (6-pin or 8-pin) to your graphics card if it requires them. Connect SATA power cables to your HDDs, SSDs, and optical drives. Connect Molex power cables to older peripherals or fans if needed.

            4.  Cable Management: Neatly arrange the power cables within the case to ensure good airflow and prevent obstruction. Use zip ties or Velcro straps to secure them.

            5.  Choosing the Right Wattage: Ensure your power supply provides enough wattage to power all your components under load. Use a PSU calculator to estimate your system's power requirements before purchasing.
            """
        case .case_:
            return """
            The computer case houses and protects all the internal components. Setup primarily involves placing components inside and ensuring good airflow.

            1.  Component Placement: Install the motherboard, power supply, drives, and other components inside the case, following the instructions for each component.

            2.  Airflow Management: Ensure proper airflow by installing case fans in appropriate locations (intake at the front and bottom, exhaust at the rear and top is a common configuration).

            3.  Cable Management: Neatly route and tie down cables to prevent them from obstructing airflow and to make the inside of the case tidy.

            4.  Front Panel Connections: Connect the case's front panel buttons (power, reset), USB ports, and audio jacks to the corresponding headers on the motherboard. Refer to your motherboard manual for the pinout.
            """
        case .keyboard:
            return """
            A keyboard is used for inputting text and commands. Setup is usually straightforward.

            1.  Cable Connection (if wired): Connect the keyboard's USB cable to an available USB port on your computer.

            2.  Battery Installation/Charging (if wireless): If it's a wireless keyboard, install batteries or charge it according to the manufacturer's instructions.

            3.  Pairing (if Bluetooth): For Bluetooth keyboards, you'll need to pair it with your computer through the operating system's Bluetooth settings.

            4.  Driver Installation (if necessary): Some advanced keyboards may require driver installation for full functionality and customization.
            """
        case .mouse:
            return """
            A mouse is used for navigation and interaction with the computer's graphical interface. Setup is generally simple.

            1.  Cable Connection (if wired): Connect the mouse's USB cable to an available USB port on your computer.

            2.  Battery Installation/Charging (if wireless): If it's a wireless mouse, install batteries or charge it according to the manufacturer's instructions.

            3.  Pairing (if Bluetooth): For Bluetooth mice, you'll need to pair it with your computer through the operating system's Bluetooth settings.

            4.  Driver Installation (if necessary): Some gaming or advanced mice may require driver installation for customization of DPI, buttons, and lighting.
            """
        case .cables:
            return """
            Cables are essential for connecting various components. Proper use and management are important.

            1.  Use the Right Cables: Ensure you are using the correct type of cable for each connection (e.g., HDMI for video, SATA for data, power cables for drives).

            2.  Secure Connections: Make sure all cable connections are firm and secure. Loose connections can lead to malfunctions.

            3.  Neat Management: Organize cables to improve airflow inside the case and to prevent them from getting tangled or damaged. Use zip ties or Velcro straps.

            4.  Avoid Over Bending: Do not bend cables excessively, especially near the connectors, as this can damage the wires inside.
            """
        case .webcam:
            return """
            A webcam is used for video communication and recording. Setup is usually quick.

            1.  USB Connection: Connect the webcam's USB cable to an available USB port on your computer.

            2.  Driver Installation (if necessary): Most modern webcams are plug-and-play, but some may require driver installation from the manufacturer's website for full functionality.

            3.  Placement: Position the webcam at your desired location, usually on top of your monitor or on a tripod.

            4.  Software Configuration: You may need to configure the webcam settings within the application you are using it with (e.g., video conferencing software, recording software).
            """
        }
    }
}

func tipsGrabber(for prediction: String) -> String {
    switch prediction.lowercased() {
    case "motherboard":
        return Tips.motherboard.description
    case "cpu":
        return Tips.cpu.description
    case "gpu":
        return Tips.gpu.description
    case "ram":
        return Tips.ram.description
    case "hdd":
        return Tips.hdd.description
    case "monitor":
        return Tips.monitor.description
    case "power supply":
        return Tips.powerSupply.description
    case "case":
        return Tips.case_.description
    case "keyboard":
        return Tips.keyboard.description
    case "mouse":
        return Tips.mouse.description
    case "cables":
        return Tips.cables.description
    case "webcam":
        return Tips.webcam.description
    default:
        return "No tips available for this component."
    }
}
