//SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

/**
 * @title InstaAutomation
 * @dev Insta-Aave-v3-Automation
 */

import "./events.sol";
import "./interfaces.sol";

abstract contract Resolver is Events {
	InstaAaveAutomation internal immutable automation =
		InstaAaveAutomation(0x7eE533CB0642f18191D2927bdA735c3830B355BB);

	function submitAutomationRequest(
		uint256 safeHealthFactor,
		uint256 thresholdHealthFactor
	)
		external
		payable
		returns (string memory _eventName, bytes memory _eventParam)
	{
		automation.submitAutomationRequest(
			safeHealthFactor,
			thresholdHealthFactor
		);

		(_eventName, _eventParam) = (
			"LogSubmitAutomation(uint256,uint256)",
			abi.encode(safeHealthFactor, thresholdHealthFactor)
		);
	}

	function cancelAutomationRequest()
		external
		payable
		returns (string memory _eventName, bytes memory _eventParam)
	{
		automation.cancelAutomationRequest();
		(_eventName, _eventParam) = ("LogCancelAutomation()", "0x");
	}

	function updateAutomationRequest(
		uint256 safeHealthFactor,
		uint256 thresholdHealthFactor
	)
		external
		payable
		returns (string memory _eventName, bytes memory _eventParam)
	{
		automation.cancelAutomationRequest();

		automation.submitAutomationRequest(
			safeHealthFactor,
			thresholdHealthFactor
		);

		(_eventName, _eventParam) = (
			"LogUpdateAutomation(uint256,uint256)",
			abi.encode(safeHealthFactor, thresholdHealthFactor)
		);
	}
}

contract ConnectV2InstaAaveV3Automation is Resolver {
	string public constant name = "Insta-Aave-V3-Automation-v1";
}
