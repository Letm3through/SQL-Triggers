CREATE FUNCTION error()
RETURNS TRIGGER AS $$
BEGIN
IF NEW.start_time = OLD.start_time
AND NEW.passenger_email = OLD.passenger_email
AND OLD.accepted = TRUE
THEN RAISE NOTICE 'You cannot assign two car rides with the same starting time to a passenger.';
END IF;
RETURN NULL;
END; $$ LANGUAGE PLPGSQL;

CREATE TRIGGER error
BEFORE UPDATE
ON bids
FOR EACH ROW
 EXECUTE PROCEDURE error();
