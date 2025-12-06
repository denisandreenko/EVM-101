import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { parseEther } from "ethers";

export default buildModule("KingBreakerModule", (m) => {
  const kingBreaker = m.contract("KingBreaker");
  
  const kingAddress = "0xb8684cD7c384397496Ac5A03b7e52972bbCB1f03";
  
  m.call(kingBreaker, "becomeKing", [kingAddress], {
    value: parseEther("0.002")
  });

  return { kingBreaker };
});