import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("RecoveryModule", (m) => {
  const targetAddress = "0x0000000000000000000000000000000000000000"; // Replace with actual Recovery contract address
  
  const recoveryExploit = m.contract("RecoveryExploit");
  
  m.call(recoveryExploit, "recover", [targetAddress]);

  return { recoveryExploit };
});

