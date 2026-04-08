Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4A34FF5D;
	Wed,  8 Apr 2026 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775622543; cv=none; b=tWJbmNTqy3I2KLU0oy4orejieavByt1uN9qFhG4Mck+DDFT3ORVNa5LSROuguIqdUyNbVf/tdGj9B4biyxATDBS1nWsnekUU87l9JvjpfWLB6DINBn4/VfkISKpqIRz7zkWGBH63iD0za6kD2jRurtS9xXTxWcMHBFAijVRpjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775622543; c=relaxed/simple;
	bh=gIue7xhb+6umrvt6zrl0pu0AG4mzGGaSw7XwGrWIFyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6zVC3kEXVgKWL/A0TFAjSkOLDeqQD1/vpIjNPHWFzBFoCpAq55QlXxsreOzejigUqrRIRwgh8y9YlFtncC/t7eB/vg/PA6/clk+n47S5vAzlwshRdNSzHwzpJDdMz1ezxikQ5UishMeZ+NWKhKJp1+A7TdOKm83D48o/Vakgcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cA7AHPUS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cA7AHPUS"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EX9bc2302449;
	Wed, 8 Apr 2026 04:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KHkgA5
	rnezyfdvWUSpptQbGO1pU1LUddvMA3ATcHhUg=; b=cA7AHPUSrBV+ZWmwPGv3GF
	rmVRMemyaL2uqlhRj0ZNnydTQq6jeSMIF6OxD9i0X1EQsGYYzpj3T3KpvwC4l5G9
	5DYCmJVocFXiaCckyl6k2RCKdT8KdlgrECCDyw+nWVLQAfs+PLmkuYhumHZUzxcO
	xIS12uIzH60FeXIiNgpos1gLKbR4otAllAMJ+uEgeMbHpAo3bOJzV//IShlnbJ70
	dm6o9gE6LYgDRUni1ISMhlkmt9BleQLvwOc0SeSdI1DEafb1mGIshvgTRbefe4H6
	T9ImOYl8uigZ9E7xzxU0DtwfNmS4cb6IQSN8AFRBNC8A5zkk0QtUt0cxNfH1vWHQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fe77r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380PVto026707;
	Wed, 8 Apr 2026 04:28:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7wy0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384Sbsd44761402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 673CF20043;
	Wed,  8 Apr 2026 04:28:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 144C520040;
	Wed,  8 Apr 2026 04:28:35 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:34 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        audit@vger.kernel.org,
        Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
Date: Wed,  8 Apr 2026 09:58:34 +0530
Message-ID: <177562236431.1381144.17164983023348957945.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX0mcPefc49ttG
 HRnPg6uzlYarwby+oKuaE9JQOAmpzhrJnjokUQoK7bCsxq5BdcMjbo6jwn74OIbiEtYULUZwjjw
 dhSJjXOguNkBArM07GccMmIkD1RFLaQmdLdbA4Q0VgBU8LBLsjac+MPsyt4G4AaPTj42xz+EuGS
 VAY6LxFb7c3341jgPgDFwQg3dncxMA35l3QfzpmaTEdbiRtfPRQrVdwAPk0OJEbyLPAwVpeDAyM
 NRFkPQmIn/+uVevx/oEZr9fdrteKGJN4CnrGUKrMvuePerWjfs2xnX/SBrt4J6IFwqEID68AeUI
 /b6lBN9tg9snylC0W5VDuwq23hdqul7t4slgov4n4ae0tjJu7xQYBdnDsCpfk5lG/7Ge2RSa+8T
 IdAITNoNXh3puhDt9ibszXuN/zsRtAP4q1x4oRGx9mNz1sVxfq8ML0RAPaXxW9xCvpnb5SZoqND
 05qPTXFBv9stUslxuTw==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d5d978 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=vyRKV1McS8jDwafK7MYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZaLGr1CHOsYgM18nDSkMZNdrVDWoeUha
X-Proofpoint-GUID: 5bLdbNo0hfmNVG8pOW9EFv3CaADoIicD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Tue, 10 Mar 2026 16:08:07 +0100, Christophe Leroy (CS GROUP) wrote:
> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> targets") added generic support for AUDIT but that didn't include
> support for bi-arch like powerpc.
> 
> Commit 4b58841149dc ("audit: Add generic compat syscall support")
> added generic support for bi-arch.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
      https://git.kernel.org/powerpc/c/f26ad12356a275ab303d5d3af4790ad94acc20d7

cheers
