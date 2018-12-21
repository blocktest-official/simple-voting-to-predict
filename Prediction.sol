pragma solidity 0.4.25;

contract Prediction {
    
    address private owner;
    
    mapping(bytes32 => string) private predictionMap;
    // set as public and can be viewed by anyone
    int public uniquePredictions = 0;
    int public predictions = 0;
    
    constructor() public {
        owner = msg.sender;
    }
    
    event PredictionEvent(string blockTESTUserId, string value, int predictions, int uniquePredictions);
    
    // taking a value as string to make it easy to store the predictions
    function predict(string memory blockTESTUserId, string memory val) public {
        // making sure only owner can post the predictions
        require (tx.origin == owner, "Only owner can post predictions!");
        
        // making sure this is user's first prediction (unique)    bytes4(keccak256("fun(uint256)")), a
        // if (bytes(predictionMap[StringAsKey.convert(blockTESTUserId)]).length == 0)
        if (bytes(predictionMap[(keccak256(blockTESTUserId))]).length == 0)
            uniquePredictions += 1;
        predictions += 1;
        predictionMap[keccak256(blockTESTUserId)] = val;
        
        // emitting event
        emit PredictionEvent(blockTESTUserId, val, predictions, uniquePredictions);
    }
    
    // access this function to get your prediction
    function getPrediction(string memory blockTESTUserId) public view returns (string memory) {
        return predictionMap[keccak256(blockTESTUserId)];
    }
}
