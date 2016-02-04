package net.sagon.agilecoach;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import java.util.HashSet;
import java.util.Set;

import org.junit.Test;

public class ModelTest {

    private Model model;
    private Model model2;

    @Test
    public void modelHasDefaults() throws Exception {
        givenDefaultModel();

        thenAssertDefaults();
    }

    @Test
    public void defaultModelEqualsIsFalse() throws Exception {
        givenTwoDefaultModels();
        thenDefaultModelIdsAreEqualButModelsAreNot();
    }

    @Test
    public void initializedModelsAndIdsAreEqual() throws Exception {
        givenTwoDefaultModels();
        whenInitializingModelsToTheSameIds();
        thenModelsAndIdsAreEqual();
    }
    
    @Test
    public void initializedModelsWithDifferentIdsAreNotEqual() throws Exception {
        givenTwoDefaultModels();
        whenInitializingModelsToDifferentIds();
        thenModelsAndIdsAreNotEqual();
    }
    
    @Test
    public void nullModelsAreUnequal() throws Exception {
        givenDefaultModel();
        
        thenNullModelIsUnequal();
    }

    @Test
    public void initializedModelHasId() throws Exception {
        givenInitializedModel();
        thenModelHasId();
    }

    @Test
    public void twoDistinctInitializedModelsInASetAreUnique() throws Exception {
        givenTwoDefaultModels();
        whenInitializingModelsToDifferentIds();
        Set<Model> s = whenAddingModelsToASet();
        thenAssertSetContainsExpectedElementCount(s, 2);
    }

    @Test
    public void twoDistinctDefaultModelsInASetAreUnique() throws Exception {
        givenTwoDefaultModels();
        Set<Model> s = whenAddingModelsToASet();
        thenAssertSetContainsExpectedElementCount(s, 2);
    }

    private void thenAssertSetContainsExpectedElementCount(Set<Model> s, int count) {
        assertThat(s.size(), is(count));
    }

    private Set<Model> whenAddingModelsToASet() {
        Set<Model> s = new HashSet<Model>(2);
        s.add(model);
        s.add(model2);

        return s;
    }

    private void thenModelHasId() {
        assertThat(model.hasId(), is(true));
    }

    private void thenNullModelIsUnequal() {
        assertNotEquals(model, model2);
    }

    private void thenModelsAndIdsAreEqual() {
        assertThat(model.getId(), is(model2.getId()));
        assertEquals(model, model2);
    }

    private void givenInitializedModel() {
        givenDefaultModel();
        model.setId(100);
        model.setName("Initialized Model");
    }
    
    private void thenModelsAndIdsAreNotEqual() {
        assertThat(model.getId(), not(model2.getId()));
        assertNotEquals(model, model2);
    }
    
    private void whenInitializingModelsToTheSameIds() {
        model.setId(100);
        model2.setId(100);
    }

    private void whenInitializingModelsToDifferentIds() {
        model.setId(100);
        model2.setId(101);
    }
    
    private void thenDefaultModelIdsAreEqualButModelsAreNot() {
        assertThat(model.getId(), is(model2.getId()));
        assertNotEquals(model, model2);
    }

    private void givenTwoDefaultModels() {
        givenDefaultModel();

        model2 = new Model();
    }
    
    private void givenDefaultModel() {
        model = new Model();
    }

    private void thenAssertDefaults() {
        assertThat(model.getId(), is(-1l));
        assertThat(model.getName(), is(""));
    }

}
