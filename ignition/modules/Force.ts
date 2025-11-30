import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { parseEther } from "ethers";

export default buildModule("ForceModule", (m) => {
  const targetAddress = m.getParameter("targetAddress", "0x5BD23d41444089369428df437eA906B39a887Ba3");
  
  const forceFeeder = m.contract("ForceFeeder", [targetAddress], {
    value: parseEther("0.001"), // Send 0.001 ETH during deployment
  });

  return { forceFeeder };
});
