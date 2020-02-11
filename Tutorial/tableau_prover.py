# -*- coding: utf-8 -*-

import nltk

def testTableauProver():
    tableau_test('P | -P')
    tableau_test('P & -P')
    tableau_test('Q', ['P', '(P -> Q)'])

def tableau_test(c, ps=None, verbose=True):
    pc =  nltk.sem.Expression.fromstring(c)
    pps = [ nltk.sem.Expression.fromstring(p) for p in ps] if ps else []
    if not ps:
        ps = []
    print(
        '%s |- %s: %s'
        % (', '.join(ps), pc, nltk.inference.tableau.TableauProver().prove(pc, pps, verbose=verbose))
    )

tableau_test('-(P & Q) -> (-P | -Q)')
tableau_test('-P | -Q', ['-(P & Q)'])
