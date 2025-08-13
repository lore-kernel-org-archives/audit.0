Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93889307487
	for <audit@vger.kernel.org>; Wed, 13 Aug 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100806; cv=none; b=D6lvLBg2DxgeYHUifEPGY/FVBHEN4U6qymJIzwB88yiFUa5DMJ4UzKxCyHAx0cZsxDr4wfUgm/Zmoc7xLQH1H5L3rR5hUAh3KdWpKkr4ri5dgoaUY7Ektd9NbFdRen6/6aIhTQh3J/8zo1tVW37u0hoIlrDGzSm07J7eqMdQq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100806; c=relaxed/simple;
	bh=oYl7YVwvE/1YiUQCXhfuujKvjSA7Qfoipgheab9fuxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7Tm2q+JXlDqCqSAokzj3dSSQJqzFDy8ykS5Z4RRyim2RiScfyWcRsg3Rcs1tiEsbZEzp6gxOjENESC794D8HvvhnqU/SuhBC/kFS9Y0ZhpWQT43oMrY+x1ifV6TwUyaNnztn6Ch/ZQb9QizzS9xJRvXi/7GsbPH/LkhOKbpy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qlCyPyGP; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qlCyPyGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755100793; bh=Bl7qT/lHn+mHsxt3y+eixUAy9gRPqXymKdlAcY+t2L0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qlCyPyGPc2SXEyPvGfmO7aiG5oNXLWr7YKGtOJzkdJ1tGbOVBMWR2ZtAFoGya3c70jg5P3IkNYfG/wiAG0WqfNgEQDZfDcsGOSro3H6KswjSJqlT4AD6XQnZhh33aiOnGYeIfockUD34woN9E9fw0E2YsDVvLNc8fmXZ53G3upR22rsRiey+jcXqeK6qRe3E6CNdFDMcUONpeHc9DG6UBNhqQ8+P3sywR8Jocd090R/k3ugoh5bm5hOMV0ffU+BbIuYue6hD8IyHyadpAe/Ta1svsOQ1MojGTSnEimDqHseKAcjXesGqdHSvZAI3alKi4nAPjCkNvPlJPWc9q45pkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755100793; bh=czqn6b48HC/lWINJHt1+CTNfwRWsgYD3Lei8TV9wYxR=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JeJeSZrkqUweXIptQ/ILeSWrmnmDFnNvJ2OOLYnpWyQ8IQbNrFVtLlxJQHDCkJFTG5nZj8SjFWI/RRn+PRJxCDpwC24EVCbkobWUrGdlG/z7QNstTj2N/twbQjXeeOvYCCRBklBKGYlaxuO0fooDnspMIwaORlTNX4Nv/KnE3zJW/hgpIkjxDOiC6RSM/Gl65ZMhwtNOublfO3hHpTKurU9R6a0YC29aj9qEWaSO2YLODHYhOhW23FgYm+BLL2YJoAo2LL0byVJUhkdPVm/tES6hchurXyJ4Y2hnvN5AFyOopMewILnBfOdZXM+3XX8fUQcwNWk0FJpIgFlfGiI9Zg==
X-YMail-OSG: P8QeoBgVM1k8qu77WeV.MyPLA.UO7VGnL99tmtQIOEbC7P2rdK.iel0QenhpyAl
 3B0xl4BgQQx9mygPPmjjV73wzRF4dmKkphmrZrsSauhnmjAZ.vfnzPWOLiWMalYbnD1IUhrJG1p4
 vICkp6Kcc.KApxCprnxRT1Y2zf9U99P0IDmz23BXHQzVdktqQSj7lupRsNFRdZtYIe2FPkWWBaUq
 X5yTKcnNfLHxVKf6.6.1ccNT_2SdzpO3Eb9P5S9ZT2c6CdYM1D7aXC6uaNXGHNftE7lrNGr6na_O
 Rb0YBfDdhdTACf0GX9NghhLyN13N7xrqNkvciBwfspy7g0rMyVL7_tJO06BAUkTmG215CxJxNkoe
 .XVdWH8bFvKJxs4VKYCAOkOTmPh8ZUxAYEr_RGYnEbChJ5cV1Y9sLvwsWwAP5IiazEAMhwxs4VWr
 7vrowGlLg9bZOomqiMsVq5ycN3Wum4EmDghxSzZ_mW3rNreUSpQja3wiD5wd1kIxZDqjpSHMWRLo
 6oi8M96yw_DY8bdFyRdmTkcmR_rl5mGDwid.VDwSUZUsorTqDDuFcM7sJU_YexHlX8.cMdv4INKf
 bRL2GYVok1_05xiqFI_X77RpC26VIzYEOVx_9eG8WmUelu3BVPjZbFD7YvAEzrPgTmiol1KwXwDX
 Yn_xLtUxiBbJQEvtahelMvSzQt002K5ROxF1.zbqdH5EpqHReWvnT9Q1cNfh604kK9KGq1deFy.y
 ru4orckkF4LhkxCiFva3duNVoT6EOfrOaV03GgSC_1JnBwGSJ4XSLawqwRapgyA9ZoZ2X5dxoo3Y
 pS2qcl5QSu.kQpzghBKVxRL0bUXqaPErlPZsAl5GAktadQ0UW0vVH5FkQQ4u3dJ7hVgI2HYVjbU5
 yFcSX2CICANtfGhPT2XQzOBOt7jgz1_RTbe.ZC6Yq3e43k6h8nOBD3_T9qlfseprv86bxIktNcuo
 0FaNX3SqDacNIrjdV01lBDnHUOD64Mx9lRMDQvGNbJgAkb3C8VVLDxwUfDlaDSRxo2P6edghjmC8
 OM9fjL2pIilY3J6tWsjE2KOj7sEFvtNuLyxH19SApakCKJPgZBQ2N_j7BRAhMPHi1KV6.ZiZHyU.
 Al1IlQyIe4FoOjQruUjZzSpQx6tSsNpNHV1QJju7YDt6EbPIm1IcBnn4S9w1FYf_0OHRio6GRgDU
 HzbvGKKExFer17YAGeDtQkD1kT6ROXfOhfr9TXKZLkV1dXfqp92Q_E__9hInPcng807MowZo5EZX
 lszhcvBBdg_9zaRgKHavDu5fGMtA6pUG3.p_MMcqgKaQ_EeVbTtgvgSD_p1oMd49asQsUcYcLFir
 vO9f6uBxKLbJXEU1_WSb283nkdrOepr_OvhQ7JD0Y6KVpbapNWcbk.9ZtsWKYCJ1dReQAtfJqisF
 LJmpTgh._v5p5P4HZAYHAzJgvJzKg3i_gOgrJ.cJT8M5TM9olYJV5PKOuc.VRqz6wYoiOWfwMQBB
 jnLIGoRbflEIJgUheok9ifqDQ_Pqg6MVVbDd_RWZw9QD0zyKJ0uVYonOYecEqzE7WG_wssmeEh7w
 sCSAYm8RieiENQInebYbmCgo6NJiHdUf.Lm8vHj5bdTeEblfrBP7qWHMcGqm_VMsUnyeoZCW1HAE
 te4882UhN_gC3weKpvjW4zx70g_2t0zlLfXs5Lmpgvj0wC0ELgmiJyaI5jlowq68XFo3HWwUTkvJ
 qt25LqDs66F.p3GrUuffzviyvEGjlxF.o88LqJsDSqlCH0cYODzsKVCsmIAHKmotJ1w_IkwlDGD9
 s8PhpPHFdVZhLPkFdaUVt1yuB2yTNCPFE4e8kdF_CjktN3QI_5j1.HpP_HX4oIxD3stp_zGO2D7s
 kpPa510G09AoImCTkIqEuncCBT3RcFNRL_oj3d.5C9oMD_f25q9nyfgtw4WFT4cWfHeIJglEZ.b_
 VZ26Kwi2lP9Iuha09zgnl86eDNNUdlBbtglZpRZlgkxEkVK_9N2oFaGm8xN7qqulGf4kUqLaJtnb
 HVRAy7mBqt4K7CBhjg4fG5PFuArLOdYCf6dzyJM7WrhorWe_3ryb_rQj8VwUnNJ5pWcbpxM0anSB
 eXujAw1Z9DaXRh7LvEyAN0mcSKMtv7UeMpXANPk6sOUUXOw.1UJWjyOJPIQ6MgYmt5qsesYC1JYS
 k0jpOJHpIF8vCFulHMD5F1T26azf82O5OU.nH9IH31KxxuP3PLI.2K5Flfz_8Dc.m8rNDgxOTuVh
 9Op59KNnZ8EQ4HUGUB3tBX4giJToXBL2TejfuALmS1bDYf4fYEmDc662033ptWFirQKPWtzwHxR0
 ZbN2N8y4I6vg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 58afb31d-c4cb-40bd-b613-d7d9c2569d11
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Aug 2025 15:59:53 +0000
Received: by hermes--production-gq1-74d64bb7d7-nccgl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 59051690e0a2483e657ddd5c7a80eaf8;
          Wed, 13 Aug 2025 15:39:35 +0000 (UTC)
Message-ID: <9ec4a351-de59-4b6b-b200-3a2fd6cbd9a9@schaufler-ca.com>
Date: Wed, 13 Aug 2025 08:39:33 -0700
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] audit: add a missing tab
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 audit@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <aJwkwMRSxUAvI4dF@stanley.mountain>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <aJwkwMRSxUAvI4dF@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24260 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/12/2025 10:38 PM, Dan Carpenter wrote:
> Someone got a bit carried away deleting tabs.  Add it back.

Of course, it should be the way you want it to be, but I don't
see the reasoning. Help me understand.

>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  kernel/auditsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 1c29541c8fb6..497bda0043fb 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1778,7 +1778,7 @@ static void audit_log_exit(void)
>  						  axs->target_sessionid[i],
>  						  &axs->target_ref[i],
>  						  axs->target_comm[i]))
> -			call_panic = 1;
> +				call_panic = 1;
>  	}
>  
>  	if (context->target_pid &&
