Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F5283C9E
	for <audit@vger.kernel.org>; Wed, 13 Aug 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099914; cv=none; b=AQLrLjQCW3Af5MMKzVWZ9QJGS992FDu2IYpOLVehdJ4MMQrPY5TLHwJxVL9+TgF3pcxwjaJupzom+4Z6E0gOUvyIxU0eCHMGbPtQDr6eO3DvWzsY4SZQRcgjR/RLkfKmPKdRENnCbYWTHFhgSQMczd44HC3TXYDJVVkdtMplvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099914; c=relaxed/simple;
	bh=zXcjEktKA15SKxWz4KLdm9/We2umEWG2uPkrn3xYUwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+9Ygg0TKq2MjjKxcZAmfCd1/QFIx86p4xE6xZirWJii1n8DXHzixshWHYdDCzijbLnsobenTKLomwdifCXuMi526MDgf2MEiBpSINSb6gnI0eyRUB6coCTE1sRQIcnGXhiL5mtT/OJ6kz6YhxUZMoXN0GajNHYVe6HGZurDPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JPIrzeN/; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JPIrzeN/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755099910; bh=BENYpKLaFfD+ck6qgjlwozJC4rNd1ZZbsFSyjV7ojDQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JPIrzeN/p5yNiU2+2nLnnGh3p98p09pO90FcO+uJqCZuoJ7AqhnL89u+h2YcPnA++yzXHwNiosQDKoK1Dh6fmztJ+b/Djqkcy0uz5bgRdh4WXSdej2iKwJAo0uX0Mf6sm819PqiyUhqCHwlrPCa3N1iitYG8IKagOSrpnvOubA7H99vR20n4YiygKUPWdtCri4dcG4oLT+2CR/IIfPMnybZxjz/C+sa5C1a91PHqtejAT5lVxawr+4p2naiAsQeukLBJdXcSQJHj8wRB8Y9+9bN9DoS1T4sjI4XuCrt/GQMyimnrHP14ozn31Y4ZqUURdFw9ppPuHxAR5QnKkZ8fUA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755099910; bh=Et56T1uTV824lOWzZpnrUC+tsjAQqELyGSixLeB4EOU=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QwQFicAwy8V7BimL/2TAaJjBIZhKHF049aP4HvuoLoXZPefcz8L9zyrQd9uZRb0+BysNfnOd1+fRvStknstKLR1gS5EO0xCdI/P4eX51yezBrMAUNCkJtx1xBtzojbWHQbwCBZUtxX6RdeK5dpTtfLsdkXauJVNzKCjYEu40RYrmbV1yVt9SJFsm6Slhp6jBtIsGnJTj0pQuig2LaWFP4Y7XTogMBF668JqZfIekWz6DSiAHL5DWfdVqlBRyqMmxg3sAb2yy3mbyHg/44k55MwBLNGLOmp3upFdZDjvmZs3e/sOwbWkJcZIk6dCpJHuMnJ3p4yypeMDLRrQqwNBzgw==
X-YMail-OSG: USHvph0VM1k3lS5lMzhwDjgBPVNK1xFdwCepBI1Kf_xbV8Oywqx_MsdY2We7asG
 bZcfuMtqq_amG20RzKZ3egmGx_s4prfGjGyrMv3tMf5EcBSlb5yMSVOSY7rAmcc4q3_idpziLpD4
 urVh8sYybG_jPctp4_l_oXd7sX9L7FRH98M_Stvt2YkAvgyj8R_D.9k.G97aPLaqMUdOEZ.VL9v5
 JeL3pAtCCER6rZYQx82t1PrglrWgtx729sLGlE2q7ljVqy3q735ofkOhZRLorVF6nBUsXkjJ9ypd
 .pj3wvLLb3koD7XMYUNPvq2DIds3dq019b4sBLm149FbaV0J4jovxg0BrxX0BJvhfIa1vzxZ0oBw
 dROLUIEmtwSWwQJ3hQaunoqe7XB6J4hkRuc4dJc14Rjxh2x3Ch.k4pUWJzx1ZACQSY8FCDavArNp
 MelHQQ6Zx6pdlM3WLLB80hT6b3pQ7MsroGSyQA4lXmRrRulNZFBHPqDsmlOJfLxdxHt_Oyxk4iwB
 dIaOpDH9pZjq6BZQYlVun0.58g14Z63ovirjqFSB8U98.qZcJXgNu7QhvmoKbpYltjqNNLxtm20B
 qgGt0MpX41cOenXsQs5Ia5PImtTsedKl10Aqi.RLoJ3XY2.NyIJgH7HqZ.XjKWjcHrghi4E6uH67
 cDhtKShFqSebPmYkPo9RP1l4xrDEqYXFv.MFMOSViB6B54wnPkwTRHj0XzIe6.hSvt6M2ZDZrB_R
 DRiHY6n6ha7EQlyMcWgEU59lkIykjh5Y0JQiSRp8ekRM8uG22j6Mh1OvpyPRcjGrBEd11MoPhKqk
 L_e.tuT65n5TtR.NvCgiYnVQJI3Uo12k.PwYXgUxDMhpkcYywrpCrlOTdu5hn._cc1nrwmiLX6RB
 poy8M6T3CEBmJIJJxzbgWyVommG1iVSGU5RKwRBRYkg67dVVZXO_Z7XUQmbqsohvzPv_iQ2.Z_8l
 o_WBTgz2WaLJ_vz2viuUPAnYdB1vmOJJ0oVpgvGgXcYHalJ2EyjFAGdKZMHctQNfNCYeXlvAcm4_
 q1VUvMhsu5whUHPqweoy6unrETu4DidgN9ELruQgsYvny0mdawgKAZvciJ2M0FD.lxp6SZBO4dsz
 QkUFUnNkV5LmisXUlhDcRuO30l92qI6UkkzPZL4ClxY1JOiI1sKG9h8yJhXL2B8DrN3I7MR.RF4D
 36WRcBh3VbMn_7EdK1tYUgeDVNyaDiummoGdPUsBxb9vLnx0XfPyevAByTweOp8RsOuT8xm91XTY
 YIlJXDFFs.zwSv1vctBDOl7j1EAhA90m.PsQRvhIm92eWve6o1fu.wlDR8ADees_FES1Q30W5xRR
 bGDDdVOZCYGrWkF3ya7kvJUdiL4EZqjlRZygbMYX57bJyYldF4NfVr3dv05iWgFz6XByyaCgArYF
 SQ18I26I1XpTkmFpj8TdNsYF1OsXdUHDBVzbbsXxAMkZr7LRbWnM1s5UzqxMGzOFZ4KYInQQaoNc
 bAYpeA3TMR8ay2Z9piJHGxR58h1o7poL2JoyDGlrxUnFcC42_1R_KLbjqWx.2FxalofPx6CEMVbg
 S8te7BqpefGDAuXO_PQ2yaoV5MNJmJdIXSjsyvrb8jeUbB04c6C.KTU7jxlv97ENkJNqUDkD2JDC
 _6lHGC4jTa1HuT_s5Ja6eUUrVbGTM8XtbFcDVTzg5yOg_kUHm_Mg5l0kWWUsr5OK1YI9IuqLTvWm
 sTKDP84XoizrtAYUXAAXGtz2INZM2PLDqpVKmF.NqiUonm5Xa7tln5BRKAE.pm71bZk_Ytcj7rDg
 CZ8FkAA0emZRDIA2LiJhgdQTu94ZB8eUhZuadeCEbEorX9N4bG8NLM4mAvBj.ftz_0zRwI6DWG3e
 s2fOB8rLq13uFpXXeTkQdfdoR1NtCG55Kn6SBfKxYRjVw5Nsd0p0KmHwO_Wo9nDlXDBp4lPFPTNF
 S38C6pOPHlReDQw12.tfxz_JlcrNUoAHXssEpRt8Srjeg2bkISiHCLRJ8UiZh8v7haC_zwJe1yh8
 3hWHW236PW8CovMoeIZza.DzimjPXl3dD0NeFol40v.elPRrRUoW5tLYjoAmEbbojbou6PKz.nE_
 PB2xn_mCLHFYjxrhXSKwvlyjqqZTT_EgJnl5N.8llP_lQHgGJWD8WyPoxQ.Ku8fqD0hUCtGn15eI
 bM6ulVCYvn_mJ_bzMmh0zJT.OpadizdhrERjBbbKIq7ulfnVENe2mcvLhKrwp2MZeA7MlspwE3ko
 FPDK5tbNgJ5o2KsjErpQupHlfFV56fhuS8WTKrBa53jQXS92clrwQwgbFbhIDAw8eU7rjjC0SBn9
 0JB5kqu7bM7c-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fbe91f67-af20-4178-9641-b36eee29c4c1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Aug 2025 15:45:10 +0000
Received: by hermes--production-gq1-74d64bb7d7-khmfd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2c0ce53c687860a8975784e334adcce8;
          Wed, 13 Aug 2025 15:45:07 +0000 (UTC)
Message-ID: <f2f7f0e9-0466-420a-9761-42df5b8f0076@schaufler-ca.com>
Date: Wed, 13 Aug 2025 08:45:06 -0700
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
 <9ec4a351-de59-4b6b-b200-3a2fd6cbd9a9@schaufler-ca.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <9ec4a351-de59-4b6b-b200-3a2fd6cbd9a9@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24260 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/13/2025 8:39 AM, Casey Schaufler wrote:
> On 8/12/2025 10:38 PM, Dan Carpenter wrote:
>> Someone got a bit carried away deleting tabs.  Add it back.
> Of course, it should be the way you want it to be, but I don't
> see the reasoning. Help me understand.

OK, I see it. Looks like a rebase error.

>
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> ---
>>  kernel/auditsc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index 1c29541c8fb6..497bda0043fb 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -1778,7 +1778,7 @@ static void audit_log_exit(void)
>>  						  axs->target_sessionid[i],
>>  						  &axs->target_ref[i],
>>  						  axs->target_comm[i]))
>> -			call_panic = 1;
>> +				call_panic = 1;
>>  	}
>>  
>>  	if (context->target_pid &&
