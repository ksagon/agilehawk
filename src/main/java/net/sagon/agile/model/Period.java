package net.sagon.agile.model;

public enum Period implements InSeconds {
    DAY {
        private static final long SECONDS_IN_A_DAY = 24 * 60 * 60;

        @Override
        public long inSeconds() {
            return SECONDS_IN_A_DAY;
        }
        
        @Override
        public String toString() {
            return "Day";
        }
    },
    WEEK {
        @Override
        public long inSeconds() {
            return DAY.inSeconds() * 7;
        }
        
        @Override
        public String toString() {
            return "Week";
        }
    },
    BIWEEK {
        @Override
        public long inSeconds() {
            return WEEK.inSeconds() * 2;
        }
        
        @Override
        public String toString() {
            return "Bi-Week";
        }
    },
    MONTH {
        @Override
        public long inSeconds() {
            return DAY.inSeconds() * 30;
        }
        
        @Override
        public String toString() {
            return "Month";
        }
    }
}
