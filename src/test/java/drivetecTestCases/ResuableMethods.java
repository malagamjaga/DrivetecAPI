package drivetecTestCases;

public class ResuableMethods {

    public static String checkAgeoInRange(double actualAgeo, double expectedAgeo, double tolerance) {
        double lowerBound = expectedAgeo - tolerance;
        double upperBound = expectedAgeo + tolerance;

        if (actualAgeo < lowerBound || actualAgeo > upperBound) {
            return "Actual Ageo is NOT in the range: " + lowerBound + " to " + upperBound;
        } else {
            return "Actual Ageo is within the range: " + lowerBound + " to " + upperBound;
        }
    }
    
}
