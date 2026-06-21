#!/bin/bash

NAMESPACE="dev"
CURRENT=$(kubectl get service api -n $NAMESPACE -o jsonpath='{.spec.selector.version}')

if [ "$CURRENT" == "blue" ]; then
    echo "Duke kaluar nga Blue → Green..."
    
    # Starto Green
    kubectl scale deployment api-green -n $NAMESPACE --replicas=2
    
    # Prit te jete gati
    kubectl rollout status deployment/api-green -n $NAMESPACE
    
    # Kalo trafikun te Green
    kubectl patch service api -n $NAMESPACE -p '{"spec":{"selector":{"app":"api","version":"green"}}}'
    
    # Ndale Blue
    kubectl scale deployment api-blue -n $NAMESPACE --replicas=0
    
    echo "✅ Trafiku tani shkon te Green!"

elif [ "$CURRENT" == "green" ]; then
    echo "Duke kaluar nga Green → Blue (Rollback)..."
    
    # Starto Blue
    kubectl scale deployment api-blue -n $NAMESPACE --replicas=2
    
    # Prit te jete gati
    kubectl rollout status deployment/api-blue -n $NAMESPACE
    
    # Kalo trafikun te Blue
    kubectl patch service api -n $NAMESPACE -p '{"spec":{"selector":{"app":"api","version":"blue"}}}'
    
    # Ndale Green
    kubectl scale deployment api-green -n $NAMESPACE --replicas=0
    
    echo "✅ Rollback i suksesshëm - trafiku te Blue!"
else
    echo "Duke inicializuar Blue/Green - duke startuar Blue..."
    kubectl scale deployment api-blue -n $NAMESPACE --replicas=2
    kubectl patch service api -n $NAMESPACE -p '{"spec":{"selector":{"app":"api","version":"blue"}}}'
    echo "✅ Blue është aktiv!"
fi
