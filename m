Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9313BADB2;
	Wed,  1 Jul 2026 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896036; cv=none; b=ScIF920IPYr3kfqVmsCfCvlBVscglXce0ncoTUvr7qAu8jxJDLu+iHv/XddkQdCECJ3WswNZTQNxN6To4rBt40zoE8SVSWkyPQJCGPMx4FARZ904BNwWhaDsAMCufAAQwHl9jIs1BKvqQ/nvIg9m4Gc/jO6YcOkO/AH0APC8jYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896036; c=relaxed/simple;
	bh=acfA2nK7bh4whLOuiz/5GbblwchT0G0kI11Z6H6Rdqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dxg1Hiw4FR4E33MXHw0gER9aXiaNnbrzwkOc6645LJ/sKFz8IRNHesvYjCpGUE+hubafUqrGwQ91/GBjIO3goxMQuvSxjRZwqXYNFsMUbhsFtyljWcmuJFPdJchhBW7r4mqI1UM5YmpA049yYhDiVxzv44uJCMIH9sOQk/5V12A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUPFMWiA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUPFMWiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4E71F000E9;
	Wed,  1 Jul 2026 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782896034;
	bh=f9jOYegPwslwL2Ey/z44d8SyEF7LBm16Uq80eeOBC3Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aUPFMWiAmeCqlwyghILR5V2Xi2R/0J6HC8UOrWNzINOiSUIqtn5RptDAFLTzjoVwR
	 0Voww1Mn74eCZP0+TtFXCCbyCu88Svz85MRQToW52TKkFBnGn8u2ApXnPRtHT2dj7g
	 agcXG33i38gnZg0tmFez/V5vs+PQNBTwzpiq13p9G2QjM/ttNK7p9fK9CUbcQPLKLe
	 5acavaPdSmCXHifnDCkUK3QzR5DAHuvFIbNcLu+qwydgNVh8rRzNxUJFDFprjpieqg
	 SvUhHiZRP7l1f4g9AO5zp8m8WJ9x7o0ZaqT9awmPmwBUjm34/qREYOPAJ+JcxITULH
	 XLFamcXSOO0WA==
Message-ID: <ba00c7a8-b4d5-4d80-859b-d75e9c91ebdb@kernel.org>
Date: Wed, 1 Jul 2026 10:53:49 +0200
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, audit@vger.kernel.org,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, ritesh.list@gmail.com
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
 <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
 <fce0a701-ee58-4cb2-b34b-8aec26aaab5d@linux.ibm.com>
 <09e72f42-e180-4e2b-b379-92b755792a2c@linux.ibm.com>
 <CAHC9VhTzuO=RFtrUUuZyieVdkrM5H4ZCb1=PoL-oEEgiw38azg@mail.gmail.com>
 <ea6e629f-dac7-45dd-bb18-5cd6361fe6c4@linux.ibm.com>
 <9c53ae3f-ccfd-4e8f-ac4f-0038e9b97a7e@linux.ibm.com>
 <b1d6e9a5-34ce-42ca-906a-d4237e18be25@kernel.org>
 <50507bb3-4229-4815-90e8-c01eaad058fc@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <50507bb3-4229-4815-90e8-c01eaad058fc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 01/07/2026 à 10:09, Venkat Rao Bagalkote a écrit :
> 
> On 01/07/26 10:26 am, Christophe Leroy (CS GROUP) wrote:
>>
>>
>> Le 01/07/2026 à 06:32, Venkat Rao Bagalkote a écrit :
>>>
>>> On 01/07/26 7:44 am, Madhavan Srinivasan wrote:
>>>>
>>>> On 7/1/26 12:41 AM, Paul Moore wrote:
>>>>> On Wed, May 13, 2026 at 1:42 AM Madhavan Srinivasan 
>>>>> <maddy@linux.ibm.com> wrote:
>>>>>> On 5/13/26 10:05 AM, Harsh Prateek Bora wrote:
>>>>>>> On 11/03/26 12:49 am, Paul Moore wrote:
>>>>>>>> On Tue, Mar 10, 2026 at 11:08 AM Christophe Leroy (CS GROUP)
>>>>>>>> <chleroy@kernel.org> wrote:
>>>>>>>>> From: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>>>>
>>>>>>>>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
>>>>>>>>> targets") added generic support for AUDIT but that didn't include
>>>>>>>>> support for bi-arch like powerpc.
>>>>>>>>>
>>>>>>>>> Commit 4b58841149dc ("audit: Add generic compat syscall support")
>>>>>>>>> added generic support for bi-arch.
>>>>>>>>>
>>>>>>>>> Convert powerpc to that bi-arch generic audit support.
>>>>>>>>>
>>>>>>>>> With this change generated text is similar.
>>>>>>>>>
>>>>>>>>> Thomas has confirmed that the previously failing 
>>>>>>>>> filter_exclude/test
>>>>>>>>> is now successful both without and with this patch, see [1]
>>>>>>>>>
>>>>>>>>> [1]
>>>>>>>>> https://eur01.safelinks.protection.outlook.com/? 
>>>>>>>>> url=https%3A%2F%2Flore.kernel.org%2Fall%2F20260306115350- 
>>>>>>>>> ef265661-6d6b-4043-9bd0-8e6b437d0d67%40linutronix.de%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771399964577%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2FtCHXFR5np67gntCnXqv7Eemo5WuwaIEcywxZQzDADA%3D&reserved=0
>>>>>>>>>
>>>>>>>>> Link: https://eur01.safelinks.protection.outlook.com/? 
>>>>>>>>> url=https%3A%2F%2Fgithub.com%2Flinuxppc%2Fissues%2Fissues%2F412&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771400190794%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=4fPEX7HuGBcxOcXlcJVQvDdP7Y9InhDpbz3z%2BS9lkCQ%3D&reserved=0
>>>>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>>>>>>> ---
>>>>>>>>> Venkat, a test result with
>>>>>>>>> https://eur01.safelinks.protection.outlook.com/? 
>>>>>>>>> url=https%3A%2F%2Fgithub.com%2Flinux-audit%2Faudit- 
>>>>>>>>> testsuite&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771400214912%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=yHp3p5zNx%2BqQg2cKBsKJADWcUcKVtZstzNScBfWzF%2FQ%3D&reserved=0 would be appreciated.
>>>>>>>> Yes, I'd like to see confirmation that the audit test suite runs 
>>>>>>>> clean
>>>>>>>> on ppc systems with this patch applied, and unfortunately without a
>>>>>>>> ppc system I have no way to test this myself.
>>>>>> My bad, this is a miss from my end.
>>>>>> Venkat is already on this and will update the results here.
>>>>> Do we have an update on this?  Maybe I missed it, but I don't recall
>>>>> seeing any test results.
>>>> Venkat, did run the test but I guess he missed to respond here,
>>>> Details of his test run that he shared me in the internal chat from 
>>>> May 13.
>>>
>>>
>>> Sorry, My bad. I missed updating here. Yes, this was tested in May. 
>>> Please let me know, if a re-run is required?
>>
>> It looks like netcat (https://eur01.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Flinux.die.net%2Fman%2F1%2Fnc&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C97ac234e82884f729d1508ded7480f62%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184901648983046%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=18PJTLp9ozMqSkWWvBZmtjzjTI355Oq%2F5aqmU6zCiZE%3D&reserved=0) is not installed in you setup. Are you able to install it and rerun the test ?
> 
> 
> I investigated the failure on the RHEL 10 ppc64le test system.
> 
> 
> The netfilter_pkt failure is due to missing userspace dependencies:
> 
> Can't exec "nc": No such file or directory
> Can't exec "iptables": No such file or directory
> Can't exec "ip6tables": No such file or directory
> 
> I checked the system and confirmed that nc, ncat, iptables, and 
> ip6tables are not installed:
> 
> 
> which nc
> which ncat
> which iptables
> which ip6tables
> 
> 
> all return "not found".
> 
> The system has nftables installed (/usr/sbin/nft), but I was unable to 
> locate packages providing nc/ncat or iptables/ip6tables in the currently 
> enabled repositories (epel, rh10_base, rh10_app, rh10_crb).

Found:
- 
https://dl.fedoraproject.org/pub/epel/10/Everything/ppc64le/Packages/n/netcat-1.238-1.el10_3.ppc64le.rpm
- 
https://rpmfind.net/linux/RPM/almalinux-kitten/10/baseos/ppc64le/iptables-nft-1.8.11-6.el10.ppc64le.html
- 
https://www.rpmfind.net/linux/RPM/centos-stream/10/appstream/ppc64le/iptables-devel-1.8.11-14.el10.ppc64le.html

Does it help ?

Christophe

> 
> 
> At this point, the remaining failure appears to be an environmental 
> dependency issue rather than a test failure. Please let me know if there 
> is a recommended package/repository for EL10 ppc64le that provides 
> netcat and iptables compatibility tools, and I can re-run the test.
> 
> 
> Regards,
> 
> Venkat.
> 
>>
>> Thanks
>> Christophe
>>
>>>
>>> Regards,
>>>
>>> Venkat.
>>>
>>>>
>>>> backlog_wait_time_actual_reset/test .. ok
>>>> bpf/test ............................. ok
>>>> exec_execve/test ..................... ok
>>>> exec_name/test ....................... ok
>>>> fanotify/test ........................ ok
>>>> field_compare/test ................... ok
>>>> file_create/test ..................... ok
>>>> file_delete/test ..................... ok
>>>> file_permission/test ................. ok
>>>> file_rename/test ..................... ok
>>>> filter_exclude/test .................. ok
>>>> filter_exit/test ..................... ok
>>>> filter_saddr_fam/test ................ ok
>>>> filter_sessionid/test ................ ok
>>>> io_uring/test ........................ ok
>>>> login_tty/test ....................... ok
>>>> lost_reset/test ...................... ok
>>>> netfilter_pkt/test ................... Can't exec "nc": No such file 
>>>> or directory at netfilter_pkt/test line 83.
>>>>
>>>> Venkat, can you please re-run if possible and paste the log here.
>>>>
>>>> Thanks
>>>> Maddy
>>>>
>>>>
>>

