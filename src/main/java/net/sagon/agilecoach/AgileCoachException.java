package net.sagon.agilecoach;

public class AgileCoachException extends RuntimeException {
    private static final long serialVersionUID = 8480402967726334749L;
    
    public AgileCoachException(Exception e) {
        super(e);
    }

}
