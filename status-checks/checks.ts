import checkMain from "./check";

export default [
  {
    name: "Solidity check",
    callback: async () => {
      try {
        await checkMain();
        return "Check passed!";
      } catch (error) {
        throw new Error("Check failed!");
      }
    },
  },
];
