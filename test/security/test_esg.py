import pytest
import json

PLAN_FILE = 'test/security/fixtures/plan.json'


@pytest.fixture
def resources():
    with open(PLAN_FILE, 'r') as f:
        plan = json.load(f)
    return plan['planned_values']['root_module']['child_modules'][0]['resources']


@pytest.fixture
def security_groups(resources):
    groups = []
    for resource in resources:
        if resource['type'] == 'aci_endpoint_security_group':
            groups.append(resource)
    return groups


@pytest.fixture
def security_group_selectors(resources):
    selectors = []
    for resource in resources:
        if resource['type'] == 'aci_endpoint_security_group_selector':
            selectors.append(resource)
    return selectors


def test_flood_on_encap_disabled(security_groups):
    noncompliant = []
    for security_group in security_groups:
        if 'flood_on_encap' not in security_group['values'] or \
                security_group['values']['flood_on_encap'] != 'disabled':
            noncompliant.append(security_group['index'])
    assert len(noncompliant) == 0, \
        f"flood_on_encap should be disabled for {noncompliant}"


def test_qos_priority_must_not_be_unspecified(security_groups):
    noncompliant = []
    for security_group in security_groups:
        if 'prio' not in security_group['values'] or \
                security_group['values']['prio'] == 'unspecified':
            noncompliant.append(security_group['index'])
    assert len(noncompliant) == 0, \
        f"prio should have defined level for {noncompliant}"


def test_policy_control_enforcement_enforced(security_groups):
    noncompliant = []
    for security_group in security_groups:
        if 'pc_enf_pref' not in security_group['values'] or \
                security_group['values']['pc_enf_pref'] != 'enforced':
            noncompliant.append(security_group['index'])
    assert len(noncompliant) == 0, \
        f"pc_enf_pref should be enforced for {noncompliant}"


def test_selector_matches_on_ip(security_group_selectors):
    noncompliant = []
    for selector in security_group_selectors:
        if 'ip==' not in selector['values']['match_expression']:
            noncompliant.append(selector['index'])
    assert len(noncompliant) == 0, \
        f"match expression should have `ip==` for {noncompliant}"
