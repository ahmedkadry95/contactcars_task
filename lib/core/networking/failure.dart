abstract class Failure {}

// No internet connection
class OfflineFailure extends Failure {}

// Server Error (api doesn't return data from server)
class ServerFailure extends Failure {}

// Validation
class ValidationFailure extends Failure {}

// Unauthorized
class UnauthorizedFailure extends Failure {}

// Empty cash exception
class EmptyCacheFailure extends Failure {}
